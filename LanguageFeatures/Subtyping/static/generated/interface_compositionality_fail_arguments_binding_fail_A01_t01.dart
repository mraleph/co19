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
/**
 * @description Check that if type T0 not a subtype of a type T1, then it cannot
 * be used as an argument of type T1. Global function required argument is
 * tested.
 * @compile-error
 * @author sgrekhov@unipro.ru
 */
/*
 * This test is generated from interface_compositionality_fail_A01.dart and 
 * arguments_binding_fail_x01.dart.
 * Don't modify it. If you want to change this file, change one of the files 
 * above and then run generator.dart to regenerate the tests.
 */



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




namedArgumentsFunc1(C0<U0, U1, U2> t1, {C0<U0, U1, U2> t2}) {}
positionalArgumentsFunc1(C0<U0, U1, U2> t1, [C0<U0, U1, U2> t2]) {}

class ArgumentsBindingClass {
    ArgumentsBindingClass(C0<U0, U1, U2> t1) {}

    ArgumentsBindingClass.named(C0<U0, U1, U2> t1, {C0<U0, U1, U2> t2}) {}
    ArgumentsBindingClass.positional(C0<U0, U1, U2> t1, [C0<U0, U1, U2> t2]) {}

    factory ArgumentsBindingClass.fNamed(C0<U0, U1, U2> t1, {C0<U0, U1, U2> t2}) {
        return new ArgumentsBindingClass.named(t1, t2: t2);
    }
    factory ArgumentsBindingClass.fPositional(C0<U0, U1, U2> t1, [C0<U0, U1, U2> t2]) {
        return new ArgumentsBindingClass.positional(t1, t2);
    }

    static namedArgumentsStaticMethod(C0<U0, U1, U2> t1, {C0<U0, U1, U2> t2}) {}
    static positionalArgumentsStaticMethod(C0<U0, U1, U2> t1, [C0<U0, U1, U2> t2]) {}

    namedArgumentsMethod(C0<U0, U1, U2> t1, {C0<U0, U1, U2> t2}) {}
    positionalArgumentsMethod(C0<U0, U1, U2> t1, [C0<U0, U1, U2> t2]) {}

    set testSetter(C0<U0, U1, U2> val) {}
}

class ArgumentsBindingClassSuper {          //# 23: compile-time error
  ArgumentsBindingClassSuper(C0<U0, U1, U2> t1) {}     //# 23: compile-time error
}                                           //# 23: compile-time error

class ArgumentsBindingDesc extends ArgumentsBindingClassSuper { //# 23: compile-time error
  ArgumentsBindingDesc(C0<S0, S1, S2> t0) : super (t0) {}                  //# 23: compile-time error
}                                                               //# 23: compile-time error

main() {
  namedArgumentsFunc1(t0Instance); //# 01: compile-time error
  namedArgumentsFunc1(t1Instance, t2: t0Instance); //# 02: compile-time error
  positionalArgumentsFunc1(t0Instance); //# 03: compile-time error
  positionalArgumentsFunc1(t1Instance, t0Instance); //# 04: compile-time error
  new ArgumentsBindingClass(t0Instance); //# 05: compile-time error
  new ArgumentsBindingClass(t1Instance).namedArgumentsMethod(t0Instance); //# 06: compile-time error
  new ArgumentsBindingClass(t1Instance).namedArgumentsMethod(t1Instance, t2: t0Instance); //# 07: compile-time error
  new ArgumentsBindingClass(t1Instance).positionalArgumentsMethod(t0Instance); //# 08: compile-time error
  new ArgumentsBindingClass(t1Instance).positionalArgumentsMethod(t1Instance, t0Instance); //# 09: compile-time error
  new ArgumentsBindingClass(t1Instance).testSetter = t0Instance; //# 10: compile-time error
  ArgumentsBindingClass.namedArgumentsStaticMethod(t0Instance); //# 11: compile-time error
  ArgumentsBindingClass.namedArgumentsStaticMethod(t1Instance, t2: t0Instance); //# 12: compile-time error
  ArgumentsBindingClass.positionalArgumentsStaticMethod(t0Instance); //# 13: compile-time error
  ArgumentsBindingClass.positionalArgumentsStaticMethod(t1Instance, t0Instance); //# 14: compile-time error
  new ArgumentsBindingClass.named(t0Instance); //# 15: compile-time error
  new ArgumentsBindingClass.named(t1Instance, t2: t0Instance); //# 16: compile-time error
  new ArgumentsBindingClass.positional(t0Instance); //# 17: compile-time error
  new ArgumentsBindingClass.positional(t1Instance, t0Instance); //# 18: compile-time error
  new ArgumentsBindingClass.fNamed(t0Instance); //# 19: compile-time error
  new ArgumentsBindingClass.fNamed(t1Instance, t2: t0Instance); //# 20: compile-time error
  new ArgumentsBindingClass.fPositional(t0Instance); //# 21: compile-time error
  new ArgumentsBindingClass.fPositional(t1Instance, t0Instance); //# 22: compile-time error
  new ArgumentsBindingDesc(t0Instance); //# 23: compile-time error
}
