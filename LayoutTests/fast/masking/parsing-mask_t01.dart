/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion
 * @description
 */
import "dart:html";
import "../../testharness.dart";
import "../../testcommon.dart" as c;

const String htmlEL1 = r'''
<style>
* { font-size: 16px; }
div { font-size: 8px; }
</style>
''';

String computedStyle(String property, String value) {
    var div = document.createElement("div");
    document.body.append(div);
    div.style.setProperty(property, value);
    var computedValue = div.getComputedStyle().getPropertyValue(property);
    div.remove();
    return computedValue;
}

String innerStyle(String property, String value) {
    var div = document.createElement("div");
    div.style.setProperty(property, value);
    return div.style.getPropertyValue(property);
}

void testComputed(String property, String value, String expected) {
    shouldBe(computedStyle(property, value), expected, "testComputed($property, $value, $expected)");
}

void testInner(String property, String value, String expected) {
     shouldBe(c.stripQuotes(innerStyle(property, value)), expected, "testInner($property, $value, $expected)");
}

void negativeTest(String property, String value) {
// original settings for "expected" does not work:
    shouldBe(innerStyle(property, value), null, "negativeTest($property, $value)/innerStyle");
   shouldBe(computedStyle(property, value), 'none', "negativeTest($property, $value)/computedStyle");

// "expected" == "" works, but not specified:
//    shouldBe(computedStyle(property, value), '', "negativeTest($property, $value)/computedStyle");
//    shouldBe(innerStyle(property, value), '', "negativeTest($property, $value)/innerStyle");

}

void main() {
    description('Test that clip-path shapes accept different length units');
    document.head.appendHtml(htmlEL1, treeSanitizer: new NullTreeSanitizer());

    // test mask-image
    testInner("-webkit-mask", "none", "none");
    testInner("-webkit-mask", "none, none", "none, none");
    testInner("-webkit-mask", "none, none, none", "none, none, none");
    testInner("-webkit-mask", "url(file:///image.png), none", "url(file:///image.png), none");
    testInner("-webkit-mask", "none, url(file:///image.png)", "none, url(file:///image.png)");


    // test mask-position
    testInner("-webkit-mask", "top left", "0% 0%");
    testInner("-webkit-mask", "bottom right", "100% 100%");
    testInner("-webkit-mask", "left bottom", "0% 100%");
    testInner("-webkit-mask", "right top", "100% 0%");
    testInner("-webkit-mask", "center", "50% 50%");
    testInner("-webkit-mask", "none top", "none 50% 0%");
    testInner("-webkit-mask", "none bottom", "none 50% 100%");
    testInner("-webkit-mask", "none right", "none 100% 50%");
    testInner("-webkit-mask", "none top right", "none 100% 0%");
    testInner("-webkit-mask", "none bottom left", "none 0% 100%");
    testInner("-webkit-mask", "none right", "none 100% 50%");
    testInner("-webkit-mask", "none left", "none 0% 50%");
    testInner("-webkit-mask", "center 50%", "50% 50%");
    testInner("-webkit-mask", "50px 50%", "50px 50%");
    testInner("-webkit-mask", "center left", "0% 50%");
    testInner("-webkit-mask", "top center", "50% 0%");
    testInner("-webkit-mask", "left 10px top 15px", "left 10px top 15px");
    testInner("-webkit-mask", "left 10% top 30%", "left 10% top 30%");
    testInner("-webkit-mask", "right top 15px", "right 0% top 15px");
    testInner("-webkit-mask", "left 10px center", "left 10px top 50%");
    testInner("-webkit-mask", "center top 20px", "left 50% top 20px");
    testInner("-webkit-mask", "center left 30px", "left 30px top 50%");
    testInner("-webkit-mask", "left 20% top", "left 20% top 0%");
    testInner("-webkit-mask", "center center", "50% 50%");

    testInner("-webkit-mask-position", "left 10px top 15px", "left 10px top 15px");
    testInner("-webkit-mask-position", "left 10% top 30%", "left 10% top 30%");
    testInner("-webkit-mask-position", "right top 15px", "right 0% top 15px");
    testInner("-webkit-mask-position", "left 10px center", "left 10px top 50%");
    testInner("-webkit-mask-position", "center top 20px", "left 50% top 20px");
    testInner("-webkit-mask-position", "center left 30px", "left 30px top 50%");
    testInner("-webkit-mask-position", "left 20% top", "left 20% top 0%");

    // test mask-source-type
    testInner("mask-source-type", "alpha", "alpha");
    testInner("mask-source-type", "luminance", "luminance");
    testInner("mask-source-type", "auto", "auto");
    testComputed("mask-source-type", "alpha", "alpha");
    testComputed("mask-source-type", "auto", "alpha");
    testComputed("mask-source-type", "luminance", "luminance");
    testComputed("mask-source-type", "", "alpha");

    // test mask-repeat
    testInner("-webkit-mask", "repeat-x", "repeat-x");
    testInner("-webkit-mask", "repeat-y", "repeat-y");
    testInner("-webkit-mask", "repeat", "repeat");
    testInner("-webkit-mask", "space", "space");
    testInner("-webkit-mask", "no-repeat", "no-repeat");
    testInner("-webkit-mask", "repeat space", "repeat space");
    testInner("-webkit-mask", "repeat round", "repeat round");
    testInner("-webkit-mask", "repeat no-repeat", "repeat no-repeat");
    testInner("-webkit-mask", "repeat space, repeat-x", "repeat space, repeat-x");
    testInner("-webkit-mask", "repeat none", "none repeat");
    testInner("-webkit-mask", "none repeat", "none repeat");

    // test mask-origin / mask-clip
    testInner("-webkit-mask", "padding-box", "padding-box padding-box");
    testInner("-webkit-mask", "border-box", "border-box border-box");
    testInner("-webkit-mask", "content-box", "content-box content-box");
    testInner("-webkit-mask", "padding-box none", "none padding-box padding-box");
    testInner("-webkit-mask", "none padding-box", "none padding-box padding-box");
    testInner("-webkit-mask", "padding-box content-box", "padding-box content-box");
    testInner("-webkit-mask", "content-box content-box", "content-box content-box");
    testInner("-webkit-mask", "padding-box border-box", "padding-box border-box");
    testInner("-webkit-mask", "padding-box border-box none", "none padding-box border-box");
    testInner("-webkit-mask", "none padding-box border-box", "none padding-box border-box");

    // test mask-size
    testInner("-webkit-mask", "none left top / auto", "none 0% 0% / auto");
    testInner("-webkit-mask", "none left top / auto auto", "none 0% 0% / auto");
    testInner("-webkit-mask", "none left top / 100%", "none 0% 0% / 100%");
    testInner("-webkit-mask", "none left top / 100% 100%", "none 0% 0% / 100% 100%");
    testInner("-webkit-mask", "none left top / 0%", "none 0% 0% / 0%");
    testInner("-webkit-mask", "none left top / auto 0%", "none 0% 0% / auto 0%");
    testInner("-webkit-mask", "none left top / cover", "none 0% 0% / cover");
    testInner("-webkit-mask", "none left top / contain", "none 0% 0% / contain");
    testInner("-webkit-mask", "none left 20px top 10px / contain", "none left 20px top 10px / contain");
    testInner("-webkit-mask", "none left 20px top / contain", "none left 20px top 0% / contain");

    // combinations
    testInner("-webkit-mask", "none padding-box content-box", "none padding-box content-box");
    testInner("-webkit-mask", "none padding-box", "none padding-box padding-box");
    testInner("-webkit-mask", "none top", "none 50% 0%");
    testInner("-webkit-mask", "none center right 20px", "none right 20px top 50%");
    testInner("-webkit-mask", "none border-box left top", "none 0% 0% border-box border-box");
    testInner("-webkit-mask", "none border-box left top 20px", "none left 0% top 20px border-box border-box");
    testInner("-webkit-mask", "none border-box content-box left top repeat-x", "none 0% 0% repeat-x border-box content-box");
    testInner("-webkit-mask", "none border-box content-box left top / auto repeat-x", "none 0% 0% / auto repeat-x border-box content-box");
    testInner("-webkit-mask", "none border-box content-box right 0px center / auto repeat-x", "none right 0px top 50% / auto repeat-x border-box content-box");

    // FIXME: Computed style not yet implemented.
    // testComputed("-webkit-mask", "", "");
    // https://bugs.webkit.org/show_bug.cgi?id=103021

    // negative tests
    negativeTest("-webkit-mask", "top none left");
    negativeTest("-webkit-mask", "right none bottom");
    negativeTest("-webkit-mask", "right right");
    negativeTest("-webkit-mask", "left left");
    negativeTest("-webkit-mask", "top top");
    negativeTest("-webkit-mask", "bottom bottom");
    negativeTest("-webkit-mask", "50% none 50%");
    negativeTest("-webkit-mask", "repeat-x repeat-x");
    negativeTest("-webkit-mask", "space repeat-y");
    negativeTest("-webkit-mask", "repeat space space");
    negativeTest("-webkit-mask", "padding-box border-box content-box");
    negativeTest("-webkit-mask", "none / auto");
    negativeTest("-webkit-mask", "none repeat-x / auto");
    negativeTest("-webkit-mask", "none border-box / auto");
    negativeTest("-webkit-mask", "none top left / cover 100%");
    negativeTest("-webkit-mask", "scroll");
    negativeTest("-webkit-mask", "fixed");
    negativeTest("-webkit-mask", "local");
    negativeTest("-webkit-mask", "space scroll");
    negativeTest("-webkit-mask", "none scroll");
    negativeTest("-webkit-mask", "none top left / auto repeat-x scroll border-box border-box");
    negativeTest("-webkit-mask", "right top left");
    negativeTest("-webkit-mask", "center left center");
    negativeTest("-webkit-mask", "center top center");
    negativeTest("-webkit-mask", "center right bottom");
    negativeTest("-webkit-mask", "top solid bottom");
    negativeTest("-webkit-mask", "none top left right center top / auto repeat-x scroll border-box border-box");
    negativeTest("-webkit-mask", "none center center 20px / auto repeat-x scroll border-box border-box");
    negativeTest("-webkit-mask", "none top 20px right 30px center / auto repeat-x scroll border-box border-box");
    negativeTest("-webkit-mask", "none top 20px top 30px / auto repeat-x scroll border-box border-box");
    negativeTest("-webkit-mask", "none top 20px bottom / auto repeat-x scroll border-box border-box");

    negativeTest("mask-source-type", "rubbish");
    negativeTest("mask-source-type", "");
    negativeTest("mask-source-type", "center");
    negativeTest("mask-source-type", "repeat");

    checkTestFailures();
}
