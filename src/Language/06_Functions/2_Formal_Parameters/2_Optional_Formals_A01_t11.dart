/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Optional parameters may be specified and provided with default values.
 * defaultFormalParameter:
 *   normalFormalParameter ('=' expression)?
 * ;
 * defaultNamedParameter:
 *   normalFormalParameter (':' expression)?
 * ;
 * @description Checks that reassigning a const optional parameter inside the function
 * produces a static warning and a NoSuchMethodError.
 * @static-warning
 * @author rodionov
 * @reviewer kaigorodov
 * @issue 5885
 */

foo({const p: 1}) {
  try {
    p = 1;
    Expect.fail("NoSuchMethodError expected");
  } on NoSuchMethodError catch(ok) {}
}

main() {
  foo();
}