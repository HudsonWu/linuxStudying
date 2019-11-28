#!/usr/bin/env python3

# -*- coding: utf-8 -*-

# https://github.com/amyangfei/GorMW

from gor.middleware import TornadoGor
import requests
import time

def back_result(my_data):
    url = "http://staging.server/example/api/path"
    r = requests.post(url, data = my_data)
    print(r.content)

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
        print('Error: replay status [%s] diffs from response status [%s]' % (replay_status, resp_status))
        back_result(my_data)
    else:
        print('replay status is same as response status\n')
        if replay_body != resp_body:
            print('Error: replay body diffs from response body')
            back_result(my_data)
        else:
            print('replay body is same as response body\n')
            

if __name == '__main__':
    proxy = TornadoGor()
    proxy.on('request', on_request)
    proxy.run()
