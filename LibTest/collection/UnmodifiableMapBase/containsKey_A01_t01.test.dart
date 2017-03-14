/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion bool containsKey(Object key)
 * Returns [true] if this map contains the given [key].
 * Returns [true] if any of the keys in the map are equal to [key] according to
 * the equality used by the map.
 * @description Checks that [true] is returned if this map contains given [key].
 * @author iarkh@unipro.ru
 */
import "dart:collection";
import "../../../Utils/expect.dart";
import "unmodifiablemapbase.lib.dart";

main() {
  UnmodifiableMapBase base = new UnmodifiableMapBaseImpl({});
  Expect.isFalse(base.containsKey(null));

  base = new UnmodifiableMapBaseImpl({0 : 0, 1 : 4});
  Expect.isFalse(base.containsKey(null));

  base = new UnmodifiableMapBaseImpl({0 : 0, null : 15, 1 : 4});
  Expect.isTrue(base.containsKey(null));
}
