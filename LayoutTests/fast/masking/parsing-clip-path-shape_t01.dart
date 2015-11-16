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
     shouldBe(innerStyle(property, value), expected, "testInner($property, $value, $expected)");
}

void negativeTest(String property, String value) {
    testInner(property, value, null); // this does not work
//    testInner(property, value, null); // this works, but not specified
    testComputed(property, value, 'none');
}

void main() {
    description('Test that clip-path shapes accept different length units');
    document.head.appendHtml(htmlEL1, treeSanitizer: new NullTreeSanitizer());

    // absolute lengths - number serialization, units
    testInner("-webkit-clip-path", "circle(0 at 0 0)", "circle(0px at 0% 0%)");
    testInner("-webkit-clip-path", "circle(1px at -1px +1px)", "circle(1px at -1px 1px)");
    testInner("-webkit-clip-path", "circle(1.5px at -1.5px +1.5px)", "circle(1.5px at -1.5px 1.5px)");
    testInner("-webkit-clip-path", "circle(.5px at -.5px +.5px)", "circle(0.5px at -0.5px 0.5px)");
    
    // font-relative lengths - number serialization, units, resolution
    testInner("-webkit-clip-path", "circle(1em at -1em +1em)", "circle(1em at -1em 1em)");
    testInner("-webkit-clip-path", "circle(1.5em at -1.5em +1.5em)", "circle(1.5em at -1.5em 1.5em)");
    testInner("-webkit-clip-path", "circle(.5em at -.5em +.5em)", "circle(0.5em at -0.5em 0.5em)");
    
    testInner("-webkit-clip-path", "circle(1ex at 1ex 1ex)", "circle(1ex at 1ex 1ex)");
    // FIXME: Add ch test when it is supported
    testInner("-webkit-clip-path", "circle(1rem at 1rem 1rem)", "circle(1rem at 1rem 1rem)");
    
    testComputed("-webkit-clip-path", "circle(1.5em at .5em 1em)", "circle(12px at 4px 8px)");
    testComputed("-webkit-clip-path", "circle(1.5rem at .5rem 1rem)", "circle(24px at 8px 16px)");
    
    // viewport-percentage lengths - units, resolution
    testInner("-webkit-clip-path", "circle(1vw at 1vw 1vw)", "circle(1vw at 1vw 1vw)");
    testInner("-webkit-clip-path", "circle(1vh at 1vh 1vh)", "circle(1vh at 1vh 1vh)");
    testInner("-webkit-clip-path", "circle(1vmin at 1vmin 1vmin)", "circle(1vmin at 1vmin 1vmin)");
    
    testComputed("-webkit-clip-path", "circle(1.5vw at .5vw 1vw)", "circle(12px at 4px 8px)");
    testComputed("-webkit-clip-path", "circle(1.5vh at .5vh 1vh)", "circle(9px at 3px 6px)");
    testComputed("-webkit-clip-path", "circle(1.5vmin at .5vmin 1vmin)", "circle(9px at 3px 6px)");
    
    // percentage lengths - units
    testComputed("-webkit-clip-path", "circle(150% at 50% 100%)", "circle(150% at 50% 100%)");
    testComputed("-webkit-clip-path", "inset(45% 45% 90% 60% round 25% 10%)", "inset(45% 45% 90% 60% round 25% 10%)");
    testComputed("-webkit-clip-path", "ellipse(100% 100% at 100% 100%)", "ellipse(100% 100% at 100% 100%)");
    testComputed("-webkit-clip-path", "polygon(10% 20%, 30% 40%, 40% 50%)", "polygon(10% 20%, 30% 40%, 40% 50%)");
    
    // reject non-lengths
    negativeTest("-webkit-clip-path", "circle(1 at 1px 1px)");
    negativeTest("-webkit-clip-path", "circle(px at 1px 1px)");
    negativeTest("-webkit-clip-path", "circle(1p at 1px 1px)");
    negativeTest("-webkit-clip-path", "circle(calc() at 1px 1px)");
    
    // reject negative radiuses
    negativeTest("-webkit-clip-path", "circle(-1.5px at -1.5px +1.5px)");
    negativeTest("-webkit-clip-path", "inset(1cm 1mm 1in 1px round -1pt, 1pc)");
    negativeTest("-webkit-clip-path", "inset(1cm 1mm 1in 1px round 1pt -1pc)");
    negativeTest("-webkit-clip-path", "ellipse(-1em 1em at 1em 1em)");
    negativeTest("-webkit-clip-path", "ellipse(1em -1em at 1em 1em)");
    
    // general negative tests
    negativeTest("-webkit-clip-path", "polygon(0, 0)");
    negativeTest("-webkit-clip-path", "polygon(0 0, 0)");
    negativeTest("-webkit-clip-path", "polygon(0)");
    negativeTest("-webkit-clip-path", "polygon()");
    negativeTest("-webkit-clip-path", "polygon(evenodd)");
    negativeTest("-webkit-clip-path", "polygon(nonzero)");

    checkTestFailures();
}
