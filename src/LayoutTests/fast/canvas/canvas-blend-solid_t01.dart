/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/** 
 * @description Series of tests to ensure correct results on applying different
 * blend modes.
 */
import "dart:html";
import "dart:math" as Math;
import "../../testcommon.dart";
import "../../../Utils/async_utils.dart";

main() {
  var tmpimg = document.createElement('canvas');
  tmpimg.width = 200;
  tmpimg.height = 200;
  var ctx = tmpimg.getContext('2d');

  // Create the image for blending test with images.
  var img = document.createElement('canvas');
  img.width = 200;
  img.height = 200;
  var imgCtx = img.getContext('2d');
  imgCtx.fillStyle = "red";
  imgCtx.fillRect(0,0,100,100);
  imgCtx.fillStyle = "yellow";
  imgCtx.fillRect(100,0,100,100);
  imgCtx.fillStyle = "green";
  imgCtx.fillRect(100,100,100,100);
  imgCtx.fillStyle = "blue";
  imgCtx.fillRect(0,100,100,100);


  // Create expected results.
  var blendModes =
    // [blendMode, expectations solid on solid, expectations solid on alpha, expectations alpha on solid, expectations alpha on alpha]
    [
    ['source-over',
    [[255, 0, 0, 255],[255, 255, 0, 255],[0, 128, 0, 255],[0, 0, 255, 255]],
    [[128, 0, 127, 255],[128, 128, 127, 255],[0, 64, 127, 255],[0, 0, 255, 255]],
    [[255, 0, 0, 255],[255, 255, 0, 255],[0, 128, 0, 255],[0, 0, 255, 255]],
    [[171, 0, 84, 191],[171, 171, 84, 191],[0, 85, 84, 191],[0, 0, 255, 191]]
      ],
    ['multiply',
    [[0, 0, 0, 255],[0, 0, 0, 255],[0, 0, 0, 255],[0, 0, 255, 255]],
    [[0, 0, 127, 255],[0, 0, 127, 255],[0, 0, 127, 255],[0, 0, 255, 255]],
    [[128, 0, 0, 255],[128, 128, 0, 255],[0, 64, 0, 255],[0, 0, 255, 255]],
    [[85, 0, 84, 191],[85, 85, 84, 191],[0, 43, 84, 191],[0, 0, 255, 191]]
      ],
    ['screen',
    [[255, 0, 255, 255],[255, 255, 255, 255],[0, 128, 255, 255],[0, 0, 255, 255]],
    [[128, 0, 255, 255],[128, 128, 255, 255],[0, 64, 255, 255],[0, 0, 255, 255]],
    [[255, 0, 127, 255],[255, 255, 127, 255],[0, 128, 127, 255],[0, 0, 255, 255]],
    [[171, 0, 170, 191],[171, 171, 170, 191],[0, 85, 170, 191],[0, 0, 255, 191]]
      ],
    ['overlay',
    [[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255]],
    [[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255]],
    [[128, 0, 127, 255],[128, 128, 127, 255],[0, 64, 127, 255],[0, 0, 255, 255]],
    [[85, 0, 170, 191],[85, 85, 170, 191],[0, 43, 170, 191],[0, 0, 255, 191]]
      ],
    ['darken',
    [[0, 0, 0, 255],[0, 0, 0, 255],[0, 0, 0, 255],[0, 0, 255, 255]],
    [[0, 0, 127, 255],[0, 0, 127, 255],[0, 0, 127, 255],[0, 0, 255, 255]],
    [[128, 0, 0, 255],[128, 128, 0, 255],[0, 64, 0, 255],[0, 0, 255, 255]],
    [[85, 0, 84, 191],[85, 85, 84, 191],[0, 43, 84, 191],[0, 0, 255, 191]]
      ],
    ['lighten',
    [[255, 0, 255, 255],[255, 255, 255, 255],[0, 128, 255, 255],[0, 0, 255, 255]],
    [[128, 0, 255, 255],[128, 128, 255, 255],[0, 64, 255, 255],[0, 0, 255, 255]],
    [[255, 0, 127, 255],[255, 255, 127, 255],[0, 128, 127, 255],[0, 0, 255, 255]],
    [[171, 0, 170, 191],[171, 171, 170, 191],[0, 85, 170, 191],[0, 0, 255, 191]]
      ],
    ['color-dodge',
    [[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255]],
    [[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255]],
    [[128, 0, 127, 255],[128, 128, 127, 255],[0, 64, 127, 255],[0, 0, 255, 255]],
    [[85, 0, 170, 191],[85, 85, 170, 191],[0, 43, 170, 191],[0, 0, 255, 191]]
      ],
    ['color-burn',
    [[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255]],
    [[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255]],
    [[128, 0, 127, 255],[128, 128, 127, 255],[0, 64, 127, 255],[0, 0, 255, 255]],
    [[85, 0, 170, 191],[85, 85, 170, 191],[0, 42, 170, 191],[0, 0, 255, 191]]

      ],
    ['hard-light',
    [[255, 0, 0, 255],[255, 255, 0, 255],[0, 1, 0, 255],[0, 0, 255, 255]],
    [[128, 0, 127, 255],[128, 128, 127, 255],[0, 0, 127, 255],[0, 0, 255, 255]],
    [[255, 0, 0, 255],[255, 255, 0, 255],[0, 65, 0, 255],[0, 0, 255, 255]],
    [[171, 0, 84, 191],[171, 171, 84, 191],[0, 43, 84, 191],[0, 0, 255, 191]]
      ],
    ['soft-light',
    [[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255]],
    [[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255],[0, 0, 255, 255]],
    [[128, 0, 127, 255],[128, 128, 127, 255],[0, 64, 127, 255],[0, 0, 255, 255]],
    [[85, 0, 170, 191],[85, 85, 170, 191],[0, 43, 170, 191],[0, 0, 255, 191]]
      ],
    ['difference',
    [[255, 0, 255, 255],[255, 255, 255, 255],[0, 128, 255, 255],[0, 0, 0, 255]],
    [[128, 0, 255, 255],[128, 128, 255, 255],[0, 64, 255, 255],[0, 0, 127, 255]],
    [[255, 0, 127, 255],[255, 255, 127, 255],[0, 128, 127, 255],[0, 0, 128, 255]],
    [[171, 0, 170, 191],[171, 171, 170, 191],[0, 85, 170, 191],[0, 0, 171, 191]]
      ],
    ['exclusion',
    [[255, 0, 255, 255],[255, 255, 255, 255],[0, 128, 255, 255],[0, 0, 0, 255]],
    [[128, 0, 255, 255],[128, 128, 255, 255],[0, 64, 255, 255],[0, 0, 127, 255]],
    [[255, 0, 127, 255],[255, 255, 127, 255],[0, 128, 127, 255],[0, 0, 128, 255]],
    [[171, 0, 170, 191],[171, 171, 170, 191],[0, 85, 170, 191],[0, 0, 171, 191]]
      ],
    ['hue',
    [[93, 0, 0, 255],[31, 31, 0, 255],[0, 46, 0, 255],[0, 0, 255, 255]],
    [[49, 0, 127, 255],[16, 16, 127, 255],[0, 25, 127, 255],[0, 0, 255, 255]],
    [[175, 0, 0, 255],[144, 144, 0, 255],[0, 88, 0, 255],[0, 0, 255, 255]],
    [[116, 0, 84, 191],[96, 96, 84, 191],[0, 58, 84, 191],[0, 0, 255, 191]]
      ],
    ['saturation',
    [[0, 0, 255, 255],[0, 0, 255, 255],[14, 14, 142, 255],[0, 0, 255, 255]],
    [[0, 0, 255, 255],[0, 0, 255, 255],[7, 7, 198, 255],[0, 0, 255, 255]],
    [[128, 0, 127, 255],[128, 128, 127, 255],[7, 71, 70, 255],[0, 0, 255, 255]],
    [[85, 0, 167, 191],[85, 85, 167, 191],[0, 48, 130, 191],[0, 0, 255, 191]]
      ],
    ['color',
    [[93, 0, 0, 255],[31, 31, 0, 255],[0, 47, 0, 255],[0, 0, 255, 255]],
    [[49, 0, 127, 255],[16, 16, 127, 255],[0, 24, 127, 255],[0, 0, 255, 255]],
    [[175, 0, 0, 255],[144, 144, 0, 255],[0, 88, 0, 255],[0, 0, 255, 255]],
    [[116, 0, 84, 191],[96, 96, 84, 191],[0, 58, 84, 191],[0, 0, 255, 191]]
      ],
    ['luminosity',
    [[55, 55, 255, 255],[224, 224, 255, 255],[54, 54, 255, 255],[0, 0, 255, 255]],
    [[28, 28, 255, 255],[112, 112, 255, 255],[27, 27, 255, 255],[0, 0, 255, 255]],
    [[155, 27, 127, 255],[239, 239, 127, 255],[26, 90, 127, 255],[0, 0, 255, 255]],
    [[104, 19, 167, 191],[158, 158, 167, 191],[16, 58, 167, 191],[0, 0, 255, 191]]
  ]];

  // [Scenario, alpha on background, alpha on foreground]
  var testScenario = [
    ['solid on solid', 1, 1],
    ['solid on alpha', 1, 0.5],
    ['alpha on solid', 0.5, 1],
    ['alpha on alpha', 0.5, 0.5]
  ];

  var testPoints = [{'x': 50, 'y': 50}, {'x': 150, 'y': 50}, {'x': 150, 'y': 150}, {'x': 50, 'y': 150}];

  pixelDataAtPoint(i) {
    return ctx.getImageData(testPoints[i]['x'], testPoints[i]['y'] , 1, 1).data;
  }

  checkBlendModeResult(blendMode, testScenario, expectedColors, sigma) {
    debug(testScenario);
    for (var i = 0; i < testPoints.length; i++) {
      var resultColor = pixelDataAtPoint(i);
      shouldBeCloseTo(resultColor[0], expectedColors[i][0], sigma);
      shouldBeCloseTo(resultColor[1], expectedColors[i][1], sigma);
      shouldBeCloseTo(resultColor[2], expectedColors[i][2], sigma);
      shouldBeCloseTo(resultColor[3], expectedColors[i][3], sigma);
    }
  }

  // Execute test.
  prepareTestScenario(sigma) {
    // Check each blend mode individually.
    for (var i = 0; i < blendModes.length; i++) {
      debug('Testing blend mode ${blendModes[i][0]}');
      for (var j = 0; j < testScenario.length; j++) {
        ctx.globalCompositeOperation = 'clear';
        ctx.fillRect(0,0,200,200);
        ctx.globalCompositeOperation = 'source-over';
        ctx.save();

        // Draw backdrop.
        ctx.fillStyle = 'rgba(0, 0, 255, ${testScenario[j][1]})';
        ctx.fillRect(0,0,200,200);

        // Apply blend mode.
        ctx.globalCompositeOperation = blendModes[i][0];
        ctx.globalAlpha = testScenario[j][2];
        ctx.fillStyle = "red";
        ctx.fillRect(0,0,100,100);
        ctx.fillStyle = "yellow";
        ctx.fillRect(100,0,100,100);
        ctx.fillStyle = "green";
        ctx.fillRect(100,100,100,100);
        ctx.fillStyle = "blue";
        ctx.fillRect(0,100,100,100);
        ctx.restore();

        checkBlendModeResult(blendModes[i][0], testScenario[j][0], blendModes[i][j+1], sigma);
        ctx.restore();                                  
      }
      debug('');
    }
  }

  // Run test and allow variation of results.
  prepareTestScenario(5);
}
