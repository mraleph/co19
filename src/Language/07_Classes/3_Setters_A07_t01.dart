/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion  It is a static warning if a class has a setter
 * named 'v=' with argument type T and a getter named 'v' with return type S,
 * and T may not be assigned to S.
 * @description Checks that it is a static warning if a class defines a setter named 'foo='
 * and a getter named 'foo' with argument/return types that are not mutually
 * assignable. Types in getter/setter signatures provided as type parameters with type
 * bounds that are not mutually assignable (int and String).
 * @author vasya
 * @reviewer rodionov
 */

class C<T extends int, S extends String> {
  set foo(T t) { /// static type warning
    _foo = t;
  }

  S get foo { return _foo; }
  
  var _foo;
}

main() {
  (new C<int, String>()).foo = null;
}
