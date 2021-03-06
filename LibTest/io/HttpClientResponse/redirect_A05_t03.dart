/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Future<HttpClientResponse> redirect([
 *  String method,
 *  Uri url,
 *  bool followLoops
 *  ])
 * Redirects this connection to a new URL. The default value for method is the
 * method for the current request. The default value for url is the value of the
 * HttpHeaders.locationHeader header of the current response. All body data must have
 * been read from the current response before calling redirect.
 *
 * All headers added to the request will be added to the redirection request.
 * However, any body sent with the request will not be part of the redirection
 * request.
 *
 * If followLoops is set to true, redirect will follow the redirect, even if the
 * URL was already visited. The default value is false.
 *
 * The method will ignore HttpClientRequest.maxRedirects and will always perform
 * the redirect.
 * @description Checks that followLoops is true then redirect follows the
 * redirect, even if the URL was already visited
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import "dart:async";
import "dart:convert";
import "../../../Utils/expect.dart";

var localhost = InternetAddress.loopbackIPv4.address;

test(String method) async {
  asyncStart();
  var count = 0;
  HttpServer server = await HttpServer.bind(localhost, 0);
  server.listen((HttpRequest request) {
    if (request.uri.path == "/xxx") {
      request.response.write("xxx${count}");
      request.response.close();
      if (count++ > 1) {
        new Future.delayed(new Duration(seconds: 1), () {
          server.close();
        });
      }
    } else {
      server.close();
      Expect.fail("Wrong URI:" + request.uri.path);
    }
  });

  HttpClient client = new HttpClient();
  client
      .open(method, localhost, server.port, "/xxx")
      .then((HttpClientRequest request) {
    return request.close();
  }).then((HttpClientResponse response) {
    response.transform(utf8.decoder).listen((content) {
      Expect.equals("xxx0", content);
    });
    response.redirect("GET", new Uri(path: "xxx")).then((HttpClientResponse resp) {
      resp.transform(utf8.decoder).listen((content2) {
        Expect.equals("xxx1", content2);
      });
      resp.redirect("GET", new Uri(path: "xxx"), true).then(
          (HttpClientResponse resp2) {
            resp2.transform(utf8.decoder).listen((content3) {
              Expect.equals("xxx2", content3);
              asyncEnd();
            });
      });
    });
  });
}

main() {
  test("get");
  test("head");
  test("delete");
  test("put");
  test("post");
  test("patch");
}
