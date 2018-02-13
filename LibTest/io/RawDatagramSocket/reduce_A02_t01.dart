/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Future<T> reduce(T combine(T previous, T element))
 * Reduces a sequence of values by repeatedly applying combine.
 *
 * @description Checks that if this stream contains only one event, combine
 * method is not called and the returned future is completed with this single
 * event.
 * @author ngl@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";
import "../../../Utils/async_utils.dart";

main() {
  asyncStart();
  var address = InternetAddress.LOOPBACK_IP_V4;
  RawDatagramSocket.bind(address, 0).then((producer) {
    RawDatagramSocket.bind(address, 0).then((receiver) {
      int sent = 0;
      int nCalls = 0;
      List list = [];
      RawSocketEvent combine(RawSocketEvent previous, RawSocketEvent element) {
        nCalls++;
        list.add(previous);
        list.add(element);
        return element;
      }
      producer.send([sent++], address, receiver.port);
      producer.send([sent++], address, receiver.port);
      producer.close();
      receiver.close();

      Future future = receiver.reduce(combine);
      future.then((event) {
        Expect.equals(RawSocketEvent.CLOSED, event);
        Expect.equals(0, nCalls);
        Expect.isTrue(list.isEmpty);
      }).whenComplete(() {
        asyncEnd();
      });
    });
  });
}
