/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Non-normative text: A class does not inherit members from its superinterfaces. 
 * However, its implicit interface does.
 * @description Checks that there's no static warning when members inherited from a superinterface
 * are accessed using a variable whose type is a class type implementing that superinterface and whose
 * value is null. NullPointerException is fully expected and caught.
 * @author rodionov
 * @reviewer kaigorodov
 */

abstract class I {
  int foo;
  void bar();
}

abstract class C implements I {}

main () {
  C c = null;
  
  try {
    c.foo = 1; // implicit setter
  } on NullPointerException catch (e) {
  }
  
  try {
    int i = c.foo; // implicit getter
  } on NullPointerException catch (e) {
  }
  
  try {
    c.bar(); // an explicit method
  } on NullPointerException catch (e) {
  }
}