/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion The for statement supports iteration.
 * forStatement:
 *   for '(' forLoopParts ')' statement
 * ;
 * forLoopParts:
 *   forInitializerStatement expression? ';' expressionList? |
 *   declaredIdentifier in expression |
 *   identifier in expression
 * ;
 * forInitializerStatement:
 *   localVariableDeclaration ‘;’ |
 *   expression? ';'
 * ;
 * @description Checks that it is a compile-time error when the loop parts are not separated by semicolons.
 * @compile-error
 * @author vasya
 * @reviewer rodionov
 * @reviewer iefremov
 */

main() {
  try {
    for (var i = 0 i < 1 ++i) { }
  } catch(x){}
}
