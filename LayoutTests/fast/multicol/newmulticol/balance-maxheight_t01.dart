/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion
 * @description balancing multicol with max-height
 */
import "dart:html";
import "../../../../Utils/expect.dart";
import "../../../testharness.dart";

const String htmlEL2 = r'''
    <p>There should be two identical boxes below.</p>
    <div id="mc" style="-webkit-columns:3; columns:3; max-height:2em; orphans:1; widows:1; color:olive; background:olive;">
      line<br>
      line<br>
      line<br>
    </div>
    <div id="ref" style="margin-top:1em; color:olive; background:olive;">
      line<br>
    </div>
''';

void main() {
    document.body.appendHtml(htmlEL2, treeSanitizer: new NullTreeSanitizer());
    Element mc=document.getElementById("mc");
    Element ref=document.getElementById("ref");
    Expect.equals(ref.offsetHeight, mc.offsetHeight);
    Expect.equals(document.documentElement.clientWidth, document.documentElement.scrollWidth);
}
