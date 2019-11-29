#!/usr/bin/env node

var gor = require("goreplay_middleware");

var http = require('http');
var querystring = require('querystring');

var dt = new Date();

gor.init();

gor.on("request", function(req) {
  gor.on("response", req.ID, function(resp) {
    gor.on("replay", req.ID, function(repl) {
      var contents = querystring.stringify({
        'Method': gor.httpMethod(req.http),
        'Path': gor.httpPath(req.http),
        'Body': gor.httpBody(req.http),
        'Time': dt.toFormat("YYYY-MM-DD HH24:MI:SS"),
        'MasterStatusCode': gor.httpStatus(resp.http),
        'MasterResponseBody': gor.httpBody(resp.http),
        'SlaveStatusCode': gor.httpStatus(repl.http),
        'SlaveResponseBody': gor.httpBody(repl.http)
      });
      var options = {
        host: 'staging.server',
        path: '/http/request/analysis/api',
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Content-Length': contents.length
        }
      };
      if (gor.httpStatus(resp.http) != gor.httpStatus(repl.http) || gor.httpBody(resp.http) != gor.httpBody(repl.http)) {
        console.error(`${gor.httpPath(req.http)} STATUS NOT MATCH: 'Expected ${gor.httpStatus(resp.http)}' got '${gor.httpStatus(repl.http)}'`);
        var req = http.request(options, function(res){
          res.setEncoding('utf8');
          res.on('data', function(data){
            console.error("data:", data);
          });
        });
        req.write(contents);
        req.end;
      }
      return repl;
    })
    return resp;
  })
  return req;
})
