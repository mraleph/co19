/*
 * Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion The content HTML element: select attribute
 */

import 'dart:html';
import "../../../../Utils/expect.dart";
import '../../testcommon.dart';

main() {
  test(() {

    var d = document;

    d.body.innerHtml =
      '<ul class="cls">' +
        '<li id="li1" class="shadow">1</li>' +
        '<li id="li2" class="shadow2">2</li>' +
        '<li id="li3" class="shadow">3</li>' +
        '<li id="li4">4</li>' +
        '<li id="li5" class="shadow">5</li>' +
        '<li id="li6" class="shadow2">6</li>' +
      '</ul>';

  var host = d.querySelector('.cls');
  //Shadow root to play with
  var s = createSR(host);

  var div = d.createElement('div');
  div.setInnerHtml(
    '<ul><content select=".shadow"><span id="spandex">This is fallback content</span></content></ul>',
    treeSanitizer: new NullTreeSanitizer());
  s.append(div);

  assert_equals(s.querySelector('#spandex').offsetTop, 0, 'Fallback content should not be rendered');

  assert_equals(d.querySelector('#li2').offsetTop, 0, 'Point 1: Element should not be rendered');
  assert_equals(d.querySelector('#li4').offsetTop, 0, 'Point 2: Element should not be rendered');
  assert_equals(d.querySelector('#li6').offsetTop, 0, 'Point 3: Element should not be rendered');

  assert_true(d.querySelector('#li1').offsetTop > 0, 'Point 11: Element should be rendered');
  assert_true(d.querySelector('#li3').offsetTop > 0, 'Point 12: Element should be rendered');
  assert_true(d.querySelector('#li5').offsetTop > 0, 'Point 13: Element should be rendered');

  }, 'A_10_04_02_T01_01');


  test(() {

    var d = document;

    d.body.innerHtml =
      '<ul class="cls">' +
        '<li id="li1" class="shadow">1</li>' +
        '<li id="li2" class="shadow2">2</li>' +
        '<li id="li3" class="shadow">3</li>' +
        '<li id="li4">4</li>' +
        '<li id="li5" class="shadow">5</li>' +
        '<li id="li6" class="shadow2">6</li>' +
      '</ul>';

  var host = d.querySelector('.cls');
  //Shadow root to play with
  var s = createSR(host);

  var div = d.createElement('div');
  div.setInnerHtml(
    '<ul><content select=".shadow, #li4"><span id="spandex">This is fallback content</span></content></ul>',
    treeSanitizer: new NullTreeSanitizer());
  s.append(div);

  assert_equals(s.querySelector('#spandex').offsetTop, 0, 'Fallback content should not be rendered');

  assert_equals(d.querySelector('#li2').offsetTop, 0, 'Point 1: Element should not be rendered');
  assert_equals(d.querySelector('#li6').offsetTop, 0, 'Point 2: Element should not be rendered');

  assert_true(d.querySelector('#li1').offsetTop > 0, 'Point 11: Element should be rendered');
  assert_true(d.querySelector('#li3').offsetTop > 0, 'Point 12: Element should be rendered');
  assert_true(d.querySelector('#li5').offsetTop > 0, 'Point 13: Element should be rendered');
  assert_true(d.querySelector('#li4').offsetTop > 0, 'Point 14: Element should be rendered');

  }, 'A_10_04_02_T01_02');
}