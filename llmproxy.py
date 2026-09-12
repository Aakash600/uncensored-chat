#!/usr/bin/env python3
"""Single OpenAI-compatible endpoint that routes to two llama-servers by model id.
Models: gemma3-4b-abliterated -> :8090, deepseek-coder-v2-lite -> :8091
"""
import json, re
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib import request, parse

BACKENDS = {
    'gemma3-4b-abliterated': 'http://127.0.0.1:8090',
    'deepseek-coder-v2-lite-abliterated': 'http://127.0.0.1:8091',
}
ALIAS = {'gemma3': 'gemma3-4b-abliterated', 'coder': 'deepseek-coder-v2-lite-abliterated',
         'deepseek': 'deepseek-coder-v2-lite-abliterated', 'dsc': 'deepseek-coder-v2-lite-abliterated'}

def pick_model(body):
    m = (body.get('model') or '').lower()
    if m in BACKENDS: return m
    for k, v in ALIAS.items():
        if k in m: return v
    return next(iter(BACKENDS))  # default

class H(BaseHTTPRequestHandler):
    protocol_version = 'HTTP/1.1'
    def log_message(self, *a): pass
    def _do(self):
        n = int(self.headers.get('Content-Length', 0))
        body = self.rfile.read(n) if n else b'{}'
        try: j = json.loads(body or b'{}')
        except Exception: j = {}
        mid = pick_model(j)
        backend = BACKENDS[mid]
        j['model'] = mid
        url = backend + self.path
        if self.path == '/v1/models':
            payload = {'data': [{'id': m, 'object': 'model'} for m in BACKENDS]}
            out = json.dumps(payload).encode()
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Content-Length', str(len(out)))
            self.end_headers()
            self.wfile.write(out)
            return
        req = request.Request(url, data=json.dumps(j).encode(),
                              headers={'Content-Type': 'application/json'}, method=self.command)
        try:
            with request.urlopen(req, timeout=1800) as r:
                if self.path == '/v1/chat/completions' and j.get('stream'):
                    self.send_response(200)
                    self.send_header('Content-Type', 'text/event-stream')
                    self.send_header('Cache-Control', 'no-cache')
                    self.end_headers()
                    while True:
                        chunk = r.read(4096)
                        if not chunk: break
                        self.wfile.write(chunk); self.wfile.flush()
                else:
                    data = r.read()
                    self.send_response(r.status)
                    self.send_header('Content-Type', r.headers.get('Content-Type', 'application/json'))
                    self.send_header('Content-Length', str(len(data)))
                    self.end_headers()
                    self.wfile.write(data)
        except Exception as e:
            out = json.dumps({'error': {'message': str(e)}}).encode()
            self.send_response(502); self.send_header('Content-Type', 'application/json')
            self.send_header('Content-Length', str(len(out))); self.end_headers(); self.wfile.write(out)
    do_GET = do_POST = do_OPTIONS = _do

ThreadingHTTPServer(('127.0.0.1', 8085), H).serve_forever()