/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion The return type of a factory whose signature is of the
 * form factory M or the form factory M.id is M if M is not a generic type;
 * otherwise the return type is M <T1, …, Tn>, where T1, …, Tn are the type parameters of the enclosing class.
 * @description Checks that assigning the result of invoking a factory constructor
 * to a variable whose type is not assignable to M<T1,...,Tn> produces a static warning.
 * Factory constructor name is that of an interface that specifies the constructor's enclosing
 * class as its default implementation.
 * @static-warning
 * @author rodionov
 * @reviewer iefremov
 */

class S1 {}
class S2 extends S1 {}
class S3 extends S2 {}

interface I<T, U, V> default M<T, U, V> {
  I();
}

class M<T, U, V> {
  factory I() {}
}

main() {
  I<S3, int, int> m1 = new I<S2, num, Function>();
}