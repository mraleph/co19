/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion  It is a static warning if an abstract member m is declared or
 * inherited in a concrete class C unless:
 *  - m overrides a concrete member, or
 *  - C has a noSuchMethod() method distinct from the one declared in class
 *    Object.
 * @description Checks that there is no static warning if an abstract
 * method is declared in a concrete class and it overrides a concrete method.
 * @static-clean
 * @author ngl@unipro.ru
 */

class A {
  foo([x]) {}
}

class B extends A {
  foo([x]);
}

main() {
  new B();
}
