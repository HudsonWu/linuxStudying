#!/usr/bin/env python

# -*- coding: utf-8 -*-

# https://github.com/amyangfei/GorMW

from gor.middleware import TornadoGor
import requests
import time
import sys

def back_result(my_data):
    url = "http://staging.server/example/api/path"
    r = requests.post(url, data = my_data)
    sys.stderr.write(r.content)
    sys.stderr.flush()

def on_request(proxy, msg, **kwargs):
    proxy.on('response', on_response, idx=msg.id, req=msg)

def on_response(proxy, msg, **kwargs):
    proxy.on('replay', on_replay, idx=kwargs['req'].id, req=kwargs['req'], resp=msg)

def on_replay(proxy, msg, **kwargs):
    replay_status = proxy.http_status(msg.http)
    resp_status = proxy.http_status(kwargs['resp'].http)
    replay_body = proxy.http_body(msg.http)
    resp_body = proxy.http_body(kwargw['resp'].http)
    my_data = {
        'Method': proxy.http_method(kwargs['req'].http),
        'Path': proxy.http_path(kwargs['req'].http),
        'Body': proxy.http_body(kwargs['req'].http),
        'Time': time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()),
        'MasterStatusCode': resp_status,
        'MasterResponseBody': resp_body[0:200],
        'SlaveStatusCode': replay_status,
        'SlaveResponseBody': replay_body[0:200]
    }
    if replay_status != resp_status:
        sys.stderr.write('Error: replay status [%s] diffs from response status [%s]' % (replay_status, resp_status))
        back_result(my_data)
    else:
        sys.stderr.write('replay status is same as response status\n')
        if replay_body != resp_body:
            sys.stderr.write('Error: replay body diffs from response body')
            back_result(my_data)
        else:
            sys.stderr.write('replay body is same as response body\n')
        sys.stderr.flush()
            

if __name__ == '__main__':
    proxy = TornadoGor()
    proxy.on('request', on_request)
    proxy.run()
