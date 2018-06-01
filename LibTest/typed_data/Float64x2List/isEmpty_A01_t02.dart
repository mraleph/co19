/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion bool isEmpty
 * Returns true if there are no elements in this collection.
 * @description Checks that isEmpty is read-only and cannot be set.
 * @author ngl@unipro.ru
 */

import "dart:typed_data";
import "../../../Utils/expect.dart";

main() {
  dynamic obj = new Float64x2List(0);
  try {
    obj.isEmpty = true;
    Expect.fail("[isEmpty] should be read-only");
  } on NoSuchMethodError {}
  try {
    obj.isEmpty = false;
    Expect.fail("[isEmpty] should be read-only");
  } on NoSuchMethodError {}
}