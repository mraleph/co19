/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Dart source text is represented as a sequence of Unicode code points 
 * that no longer have to be normalized to Unicode Normalization Form C.
 * @description Checks that decomposed characters in strings do not cause a compile error.
 * @author kaigorodov
 * @reviewer rodionov
 * @issue 2687, 7151
 */

main() {
 String aWithRingAbove="Å"; // Å
}
