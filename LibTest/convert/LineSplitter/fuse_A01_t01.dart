/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Converter<S, TT> fuse<TT>(Converter<T, TT> other)
 * Fuses this with other.
 * Encoding with the resulting converter is equivalent to converting with this
 * before converting with other.
 * @description Checks that encoding with the resulting converter is equivalent
 * to converting with this before converting with other.
 * @issue 29372
 * @author sgrekhov@unipro.ru
 */
import "dart:convert";
import "../../../Utils/expect.dart";

check(Converter codec, String data, String expected) {
  Expect.equals(expected, codec.convert(data));
}

class TestConverter extends Converter<List<String>, String> {
  String convert(List<String> lst) {
    String s = "";
    for (int i = 0; i < lst.length; i++) {
      s += "+" + lst[i];
    }
    return s;
  }
}

main() {
  dynamic ls = new LineSplitter();
  Converter fused = ls.fuse(new TestConverter());

  check(fused, "aaa\nbb", "+aaa+bb");
  check(fused, "aaa\nbb\rc", "+aaa+bb+c");
  check(fused, "aaa\nbb\t", "+aaa+bb\t");
}
