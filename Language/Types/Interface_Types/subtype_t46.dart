/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion A type T is more specific than a type S, written T << S, if one of the following conditions is met:
 *   - T is S.
 *   - T is ⊥
 *   - S is Dynamic.
 *   - S is a direct supertype of T.
 *   - T is a type variable and S is the upper bound of T.
 *   - T is of the form I<T1, ..., Tn > and S is of the form I <S1, ..., Sn> and Ti << Si 1 <= i <= n.
 *   - T and S are both function types, and T << S under the rules of section (Types/Function Types).
 *   - T is a function type and S is Function.
 *   - T << U and U << S.
 * T is a subtype of S, written T <: S, iff [⊥/Dynamic]T << S.
 * A type T may be assigned to a type S, written T <=> S, if either T <: S or S <: T .
 * @description Checks that a generic interface type B that is a subtype of a generic type A parameterized with type
 * arguments of B is not a subtype of A parameterized with an incompatible set of type arguments.
 * @author iefremov
 * @reviewer rodionov
 */
import "../../../Utils/expect.dart";

class A<T, S, U, W> {}
class B<S, U> extends A<S, S, U, U>{}

main() {
  Expect.isFalse(new B<int, double>() is A<int, int, double, int>);
  Expect.isFalse(new B<int, double>() is A<int, double, double, double>);
  Expect.isFalse(new B<B, B>() is A<int, B, B, B>);
  Expect.isFalse(new B<B, B>() is A<B, B, B, int>);
}