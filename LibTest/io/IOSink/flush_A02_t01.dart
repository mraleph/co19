/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Future flush()
 * This method must not be called while an [addStream] is incomplete.
 * @description Checks that [flush] causes error if [addStream] is currently
 * incomplete.
 * @author iarkh@unipro.ru
 */

import "../../../Utils/expect.dart";
import "dart:async";
import "dart:io";

class MyStreamConsumer<List> extends StreamConsumer<List> {
  MyStreamConsumer() {}
  Future addStream(Stream<List> stream) { return new Future(() => "ADD"); }
  Future close() { return new Future(() => "CLOSE").then((x) {}); }
}

main() {
  Stream<List> stream = new Stream<List>.fromIterable([[1, 2]]);
  StreamConsumer consumer = new MyStreamConsumer();
  IOSink sink = new IOSink(consumer);
  sink.addStream(stream).then((x) {
    new Future.delayed(new Duration(seconds: 3)).then((_) {
      sink.close();
    });
  });
  Expect.throws(() { sink.flush(); }, (e) => e is StateError);
}
