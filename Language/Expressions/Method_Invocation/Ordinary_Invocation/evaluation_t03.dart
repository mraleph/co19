/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Evaluation of an ordinary method invocation i of the form
 * o.m(a1 , . . . , an , xn+1 : an+1 , . . . , xn+k : an+k)
 * proceeds as follows:
 * First, the expression o is evaluated to a value vo. Next, the argument list
 * (a1 , . . . , an , xn+1 : an+1 , . . . , xn+k : an+k) is evaluated
 * yielding actual argument objects o1 , . . . , on+k . Let f be the result of
 * looking up method m in vo with respect to the current library L.
 * Let p1 . . . ph be the required parameters of f, let p1 . . . pm be the
 * positional parameters of f and let ph+1 , . . . , ph+l be the named
 * parameters declared by f.
 * If n < h, or n > m, the method lookup has failed. Furthermore, each
 * xi , n + 1 <= i <= n + k, must have a corresponding named parameter in the
 * set {ph+1 , . . . , ph+l} or the method lookup also fails. Otherwise
 * method lookup has succeeded.
 * If the method lookup succeeded, the body of f is executed with respect to
 * the bindings that resulted from the evaluation of the argument list, and
 * with this bound to vo. The value of i is the value returned after f is
 * executed.
 * @description Checks that the value of method invocation is the value returned by method m.
 * @author msyabro
 * @reviewer kaigorodov
 */
import '../../../../Utils/expect.dart';

class A {
  m() {
    return "v";
  }
}

class B extends A {
  m() {
    return false;
  }
}

class C extends B {
  m() {
    return 1;
  }
}

class D extends C {
  m() {
    return null;
  }
}

main()  {
  var classWithMethod = new A();
  Expect.equals("v", classWithMethod.m());
  
  classWithMethod = new B();
  Expect.equals(false, classWithMethod.m());
  
  classWithMethod = new C();
  Expect.equals(1, classWithMethod.m());
  
  classWithMethod = new D();
  Expect.equals(null, classWithMethod.m());
}