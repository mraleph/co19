/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Stream<RawSocketEvent> distinct([bool equals(T previous, T next)])
 * Skips data events if they are equal to the previous data event.
 *
 * The returned stream provides the same events as this stream, except that it
 * never provides two consecutive data events that are equal. That is, errors
 * are passed through to the returned stream, and data events are passed through
 * if they are distinct from the most recently emitted data event.
 *
 * Equality is determined by the provided equals method. If that is omitted,
 * the '==' operator on the last provided data element is used.
 *
 * If equals throws, the data event is replaced by an error event containing the
 * thrown error. The behavior is equivalent to the original stream emitting the
 * error event, and it doesn't change the what the most recently emitted data
 * event is.
 *
 * @description Checks that errors are passed through to the returned stream,
 * and data events are passed through if they are distinct from the most
 * recently emitted data event.
 * @author ngl@unipro.ru
 */
import "dart:io";
import "dart:async";
import "../../../Utils/expect.dart";

main() {
  List expected1 = [RawSocketEvent.write];
  List expected2 = ['ex', 'ex', 'ex'];
  asyncStart();
  var address = InternetAddress.loopbackIPv4;
  RawDatagramSocket.bind(address, 0).then((producer) {
    RawDatagramSocket.bind(address, 0).then((receiver) {
      int sent = 0;
      int counter1 = 0;
      int counter2 = 0;
      var received = 0;
      Timer timer;
      List list = [];
      List errorList = [];
      int totalSent = 0;
      int nullWriteData = 0;
      int closeEvent = 1;

      totalSent += producer.send([sent++], address, receiver.port);
      totalSent += producer.send([sent++], address, receiver.port);
      totalSent += producer.send([sent++], address, receiver.port);
      if (totalSent != sent) {
        Expect.fail('$totalSent messages were sent instead of $sent.');
      }
      producer.close();

      Stream bcs = receiver.asBroadcastStream();
      Stream s = bcs.distinct((previous, next) => throw "ex");
      s.listen((event) {
        list.add(event);
        counter1++;
      }, onError: (e) {
        errorList.add(e);
        counter2++;
      }, onDone: () {
        Expect.equals(1, counter1);
        Expect.equals(totalSent + nullWriteData, counter2);
        Expect.deepEquals(expected1, list);
        if (nullWriteData != 0) {
          expected2.add('ex');
        }
        Expect.deepEquals(expected2, errorList);
      });

      bcs.listen((event) {
        Datagram d = receiver.receive();
        if (event == RawSocketEvent.write && d == null) {
          nullWriteData = 1;
        }
        received++;
        if (timer != null) {
          timer.cancel();
        }
        timer = new Timer(const Duration(milliseconds: 200), () {
          Expect.isNull(receiver.receive());
          receiver.close();
        });
      }, onDone: () {
        if (timer != null) {
          timer.cancel();
        }
        Expect.equals(totalSent + closeEvent + nullWriteData, received);
        asyncEnd();
      });
    });
  });
}
