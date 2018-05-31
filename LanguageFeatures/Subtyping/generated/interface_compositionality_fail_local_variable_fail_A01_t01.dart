/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
 * when:
 * Interface Compositionality: T0 is an interface type
 * C0<S0, ..., Sk> and T1 is C0<U0, ..., Uk> and each Si <: Ui
 * @description Check that if type T0 is an interface type
 * C0<S0, ..., Sk> and T1 is C0<U0, ..., Uk> and not all of Si <: Ui then T0 is
 * not a subtype of T1
 * @author sgrekhov@unipro.ru
 */

import "../utils/common.dart";
import "../../../Utils/expect.dart";

abstract class U0 {}
abstract class U1 {}
abstract class U2 {}

abstract class S0 extends U0 {}
abstract class S1 extends U1 {}
// no subtype relation between S2 and U2
abstract class S2 {}

class C0<X, Y, Z> {}

C0<S0, S1, S2> t0Instance = new C0<S0, S1, S2>();
C0<U0, U1, U2> t1Instance = new C0<U0, U1, U2>();




class LocalVariableTest {

  LocalVariableTest() {
    C0<U0, U1, U2> t1 = null;
    t1 = forgetType(t0Instance);
  }

  LocalVariableTest.valid() {}

  static staticTest() {
    C0<U0, U1, U2> t1 = null;
    t1 = forgetType(t0Instance);
  }

  test() {
    C0<U0, U1, U2> t1 = null;
    t1 = forgetType(t0Instance);
  }
}

main() {
  bar () {
    C0<U0, U1, U2> t1 = null;
    t1 = forgetType(t0Instance);
  }

  Expect.throws(() {
    C0<U0, U1, U2> t1 = null;
    t1 = forgetType(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    bar();
  }, (e) => e is TypeError);

  Expect.throws(() {
    new LocalVariableTest();
  }, (e) => e is TypeError);

  Expect.throws(() {
    new LocalVariableTest.valid().test();
  }, (e) => e is TypeError);

  Expect.throws(() {
    LocalVariableTest.staticTest();
  }, (e) => e is TypeError);
}
