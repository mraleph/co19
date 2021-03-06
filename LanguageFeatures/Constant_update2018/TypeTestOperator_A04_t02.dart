/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion An expression of the form [e is T] or [e is! T] is accepted as a
 * potentially and compile-time constant expression if [e] is potentially
 * constant or compile-time constant, respectively, and [T] is a compile-time
 * constant type.
 * @description Checks that an expression of the form [e is! T] is not accepted
 * and causes compile time error if [T] is not a compile-time constant type.
 * @compile-error
 * @author iarkh@unipro.ru
 */

const dynamic test = 12345;

class A {
  A();
}

class MyClass {
  final int res;
  const MyClass(Object o) : res = o is! A ? 0 : 1;   // #02: compile-time error
}

main() {
  const bool res = test is! A;  // #01: compile-time error
}
