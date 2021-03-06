/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @author iarkh@unipro.ru
 */
import "../../../Utils/expect.dart";
import "../file_utils.dart";
import "dart:async";
import "dart:convert";
import "dart:io";

Future<ProcessResult> run_Windows(
    String executable, String script, String filename, Encoding enc) {
  return Process.run(executable, [script, "test", ">", filename],
      runInShell: true, stdoutEncoding: enc);
}

Future<ProcessResult> run_Linux(
    String executable, String script, String filename, Encoding enc) {
  return Process.run("bash",
      ["-c", executable + " " + script + " test > " + filename],
      runInShell: true, stdoutEncoding: enc);
}

run_main(Encoding enc, void run(), List<int> expected) async {
  String executable = Platform.resolvedExecutable;
  String script = Platform.script.toString();
  int called = 0;
  String filename = Directory.systemTemp.path + Platform.pathSeparator +
      getTempFileName();
  await (Platform.isWindows ?
      run_Windows(executable, script, filename, enc) :
      run_Linux(executable, script, filename, enc)).
      then((ProcessResult results) async {
    File fl = new File(filename);
    await fl.readAsBytes().then((List<int> contents) {
      fl.delete();
      Expect.listEquals(expected, contents);
    });
    called++;
  });
  Expect.equals(1, called);
}
