/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
 * when:
 * Super-Interface: T0 is an interface type with super-interfaces S0,...Sn
 * - and Si <: T1 for some i
 * @description Check that if there is no i, such that Si <: T1, then T0 is not
 * subtype of T1
 * @author sgrekhov@unipro.ru
 */
import '../../utils/common.dart';
import '../../../../Utils/expect.dart';

class T1 {}

// Missing subtype relation to T1
abstract class S0 {}
abstract class S1 {}
abstract class S2 {}

abstract class T0 implements S0, S1, S2  {}

class T implements T0 {}

T0 t0Instance = new T();
T1 t1Instance = new T1();




class LocalVariableTest {

  LocalVariableTest() {
    T1 t1 = null;
    t1 = forgetType(t0Instance);
  }

  LocalVariableTest.valid() {}

  static staticTest() {
    T1 t1 = null;
    t1 = forgetType(t0Instance);
  }

  test() {
    T1 t1 = null;
    t1 = forgetType(t0Instance);
  }
}

main() {
  bar () {
    T1 t1 = null;
    t1 = forgetType(t0Instance);
  }

  Expect.throws(() {
    T1 t1 = null;
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