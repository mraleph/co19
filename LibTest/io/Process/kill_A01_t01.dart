/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion bool kill([ProcessSignal signal = ProcessSignal.SIGTERM ])
 *
 * Kills the process.
 *
 * Where possible, sends the signal to the process. This includes Linux and
 * OS X. The default signal is ProcessSignal.SIGTERM which will normally
 * terminate the process.
 *
 * On platforms without signal support, including Windows, the call just
 * terminates the process in a platform specific way, and the signal parameter
 * is ignored.
 *
 * Returns true if the signal is successfully delivered to the process.
 * Otherwise the signal could not be sent, usually meaning that the process is
 * already dead.
 *
 * @description Checks that method [kill] kills the process and [exitCode]
 * returns a Future which completes with the exit code of the process when the
 * process completes. On Linux and OS X if the process was terminated due to a
 * signal  the exit code will be a negative value in the range -255..-1, where
 * the absolute value of the exit code is the signal number. If the process is
 * killed with ProcessSignal.SIGTERM the exit code is -15, as the signal SIGTERM
 * has number 15.
 * @author ngl@unipro.ru
 */
import "dart:async";
import "dart:io";
import "../../../Utils/expect.dart";

main() {
  Process.start('sleep', ['5']).then((Process process) {
    bool pKill = process.kill();
    Expect.isTrue(pKill);

    Expect.isTrue(process.exitCode is Future<int>);
    Future<int> eCode = process.exitCode;
    eCode.then((value) {
      Expect.isTrue(value is int);
      if (Platform.isLinux) {
        Expect.isTrue(value < 0 && value > -260);
        Expect.isTrue(value == -15);
      }
      pKill = process.kill(ProcessSignal.SIGTERM);
      Expect.isFalse(pKill);
    });
  });
}
