/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/** 
 * @description Series of tests to ensure correct behaviour of canvas.setTransform()
 */
import "../../testcommon.dart";

main() {
  dynamic ctx = createContext2d("canvas");

  debug("Reset the CTM to the initial matrix");
  ctx.beginPath();
  ctx.scale(0.5, 0.5);
  ctx.setTransform(1, 0, 0, 1, 0, 0);
  ctx.fillStyle = 'green';
  ctx.fillRect(0, 0, 100, 100);

  var imageData = ctx.getImageData(1, 1, 98, 98);
  var imgdata = imageData.data;
  shouldBe(imgdata[4], 0);
  shouldBe(imgdata[5], 128);
  shouldBe(imgdata[6], 0);

  debug("setTransform should not affect the current path");
  ctx.beginPath();
  ctx.rect(0,0,100,100);
  ctx.save();
  ctx.setTransform(0.5, 0, 0, 0.5, 10, 10);
  ctx.fillStyle = 'red';
  ctx.fillRect(0, 0, 100, 100);
  ctx.restore();
  ctx.fillStyle = 'green';
  ctx.fillRect(0, 0, 100, 100);

  imageData = ctx.getImageData(1, 1, 98, 98);
  imgdata = imageData.data;
  shouldBe(imgdata[4], 0);
  shouldBe(imgdata[5], 128);
  shouldBe(imgdata[6], 0);

  debug("setTransform should not affect the CTM outside of save() and restore()");
  ctx.beginPath();
  ctx.fillStyle = 'green';
  ctx.save();
  ctx.setTransform(0.5, 0, 0, 0.5, 0, 0);
  ctx.fillStyle = 'red';
  ctx.fillRect(0, 0, 100, 100);
  ctx.restore();
  ctx.fillRect(0, 0, 100, 100);

  imageData = ctx.getImageData(1, 1, 98, 98);
  imgdata = imageData.data;
  shouldBe(imgdata[4], 0);
  shouldBe(imgdata[5], 128);
  shouldBe(imgdata[6], 0);


  debug("stop drawing on not-invertible CTM");
  ctx.beginPath();
  ctx.fillStyle = 'green';
  ctx.fillRect(0, 0, 100, 100);
  ctx.setTransform(0, 0, 0, 0, 0, 0);
  ctx.fillStyle = 'red';
  ctx.fillRect(0, 0, 100, 100);

  imageData = ctx.getImageData(1, 1, 98, 98);
  imgdata = imageData.data;
  shouldBe(imgdata[4], 0);
  shouldBe(imgdata[5], 128);
  shouldBe(imgdata[6], 0);

  debug("setTransform with a not-invertible matrix should only stop the drawing up to the next restore()");
  ctx.beginPath();
  ctx.resetTransform();
  ctx.save();
  ctx.setTransform(0, 0, 0, 0, 0, 0);
  ctx.fillStyle = 'red';
  ctx.fillRect(0, 0, 100, 100);
  ctx.restore();
  ctx.fillStyle = 'blue';
  ctx.fillRect(0, 0, 100, 100);

  imageData = ctx.getImageData(1, 1, 98, 98);
  imgdata = imageData.data;
  shouldBe(imgdata[4], 0);
  shouldBe(imgdata[5], 0);
  shouldBe(imgdata[6], 255);

  debug("setTransform should set transform although CTM is not-invertible");
  ctx.beginPath();
  ctx.fillStyle = 'red';
  ctx.fillRect(0, 0, 100, 100);
  ctx.setTransform(0, 0, 0, 0, 0, 0);
  ctx.fillStyle = 'green';
  ctx.fillRect(0, 0, 100, 100);
  ctx.setTransform(1, 0, 0, 1, 0, 0);
  ctx.fillStyle = 'blue';
  ctx.fillRect(0, 0, 100, 100);

  imageData = ctx.getImageData(1, 1, 98, 98);
  imgdata = imageData.data;
  shouldBe(imgdata[4], 0);
  shouldBe(imgdata[5], 0);
  shouldBe(imgdata[6], 255);
}
