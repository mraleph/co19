/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @description Test the parsing of the cursor property.
 */
import "dart:html";
import "../../testcommon.dart";

main() {
  makeCursorRule(rule)
  {
    return "cursor: " + rule + ";";
  }

  roundtripCssRule(cssText)
  {
    var div = document.createElement("div");
    div.setAttribute("style", cssText);
    document.body.append(div);
    var result = div.style.cssText;
    div.remove();
    return result;
  }

  testCursorRule(rule)
  {
    var cssText = makeCursorRule(rule);
    shouldBeEqualToString(stripQuotes(roundtripCssRule(cssText)), cssText);
  }

  testInvalidCursorRule(rule)
  {
    shouldBeEqualToString(roundtripCssRule(makeCursorRule(rule)), '');
  }


  // Note that any absolute URL will suffice for these tests (can't use relative URLs
  // since they'll be converted to absolute form in the output).  I chose file URLs just
  // to avoid triggering any network activity.

  debug('Test a bunch of cursor rules which should round-trip exactly.');
  testCursorRule('auto');
  testCursorRule('none');
  testCursorRule('copy');
  testCursorRule('-webkit-grabbing');
  testCursorRule('url(file:///foo.png), crosshair');
  testCursorRule('url(file:///foo.png), url(file:///foo2.png), pointer');
  testCursorRule('url(file:///foo.png) 12 3, pointer');
  testCursorRule('url(file:///foo.png) 0 0, pointer');
  testCursorRule('url(file:///foo.png) 12 3, url(file:///foo2.png), url(file:///foo3.png) 6 7, crosshair');
  testCursorRule('url(file:///foo.png) -2 3, pointer');
  testCursorRule('url(file:///foo.png) 2 -3, pointer');
  testCursorRule('url(file:///foo.png) -1 -1, pointer');

  debug('');
  debug('Test a bunch of invalid cursor rules which shouldn\'t parse at all.');
  testInvalidCursorRule('nonexistent');
  testInvalidCursorRule('ltr');
  testInvalidCursorRule('inline');
  testInvalidCursorRule('hand');
  testInvalidCursorRule('url(file:///foo.png)');
  testInvalidCursorRule('url(file:///foo.png), url(file:///foo2.png)');
  testInvalidCursorRule('url(file:///foo.png) 12');
  testInvalidCursorRule('url(file:///foo.png) 12 3 5');
  testInvalidCursorRule('url(file:///foo.png) x y');
  testInvalidCursorRule('url(file:///foo.png) auto');
}
