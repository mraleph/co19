/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
 * when:
 * Right FutureOr: T1 is FutureOr<S1> and
 *   either T0 <: Future<S1>
 *   or T0 <: S1
 *   or T0 is X0 and X0 has bound S0 and S0 <: T1
 *   or T0 is X0 & S0 and S0 <: T1
 * @description Check that if a type T1 is Future<S1> and a type T0 is X0 and
 * X0 has bound S0 and S0 is not a subtype of Future<S1> or S1, then a type T0
 * is not a subtype of a type T1.
 * @author ngl@unipro.ru
 */
/**
 * @description Check that if type T0 not a subtype of a type T1, then it cannot
 * be used as an argument of type T1. Test mixin members. Super method required
 * argument is tested.
 * @compile-error
 * @author sgrekhov@unipro.ru
 * @author ngl@unipro.ru
 */
/*
 * This test is generated from right_FutureOr_fail_A02.dart and 
 * arguments_binding_mixin_fail_x01.dart.
 * Don't modify it. If you want to change this file, change one of the files 
 * above and then run generator.dart to regenerate the tests.
 */



import "dart:async";

class S1 {}
class S0 {}
class X0 extends S0 {
}

X0 t0Instance = new X0();
FutureOr<S1> t1Instance = new Future.value(new S1());




class ArgumentsBindingSuper1_t03 {
  void superTest(FutureOr<S1> val) {}
  void superTestPositioned(FutureOr<S1> val, [FutureOr<S1> val2]) {}
  void superTestNamed(FutureOr<S1> val, {FutureOr<S1> val2}) {}
  FutureOr<S1> get superGetter => t0Instance; //# 07: compile-time error
  void set superSetter(FutureOr<S1> val) {}
}

class ArgumentsBinding1_t03 extends Object with ArgumentsBindingSuper1_t03 {

  test() {
    superTest(t0Instance); //# 08: compile-time error

    this.superTest(t0Instance); //# 09: compile-time error

    super.superTest(t0Instance); //# 10: compile-time error

    superTestPositioned(t0Instance); //# 11: compile-time error

    this.superTestPositioned(t0Instance); //# 12: compile-time error

    super.superTestPositioned(t0Instance); //# 13: compile-time error

    superTestPositioned(t1Instance, t0Instance); //# 14: compile-time error

    this.superTestPositioned(t1Instance, t0Instance); //# 15: compile-time error

    super.superTestPositioned(t1Instance, t0Instance); //# 16: compile-time error

    superTestNamed(t0Instance); //# 17: compile-time error

    this.superTestNamed(t0Instance); //# 18: compile-time error

    super.superTestNamed(t0Instance); //# 19: compile-time error

    superTestNamed(t1Instance, val2: t0Instance); //# 20: compile-time error

    this.superTestNamed(t1Instance, val2: t0Instance); //# 21: compile-time error

    super.superTestNamed(t1Instance, val2: t0Instance); //# 22: compile-time error

    superSetter = t0Instance; //# 23: compile-time error

    this.superSetter = t0Instance; //# 24: compile-time error

    super.superSetter = t0Instance; //# 25: compile-time error

    superGetter; //# 07: compile-time error

    this.superGetter; //# 07: compile-time error

    super.superGetter; //# 07: compile-time error
  }
}

main() {
  new ArgumentsBinding1_t03().superTest(t0Instance); //# 01: compile-time error
  new ArgumentsBinding1_t03().superTestPositioned(t0Instance); //# 02: compile-time error
  new ArgumentsBinding1_t03().superTestPositioned(t1Instance, t0Instance); //# 03: compile-time error
  new ArgumentsBinding1_t03().superTestNamed(t0Instance); //# 04: compile-time error
  new ArgumentsBinding1_t03().superTestNamed(t1Instance, val2: t0Instance); //# 05: compile-time error
  new ArgumentsBinding1_t03().superSetter = t0Instance; //# 06: compile-time error
  new ArgumentsBinding1_t03().superGetter; //# 07: compile-time error
  new ArgumentsBinding1_t03().test();
}
