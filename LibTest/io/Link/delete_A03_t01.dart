/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Future<FileSystemEntity> delete({bool recursive: false})
 * Deletes this FileSystemEntity.
 *
 * If the FileSystemEntity is a directory, and if recursive is false, the
 * directory must be empty. Otherwise, if recursive is true, the directory and
 * all sub-directories and files in the directories are deleted. Links are not
 * followed when deleting recursively. Only the link is deleted, not its target.
 *
 * If recursive is true, the FileSystemEntity is deleted even if the type of the
 * FileSystemEntity doesn't match the content of the file system. This behavior
 * allows delete to be used to unconditionally delete any file system object.
 *
 * Returns a Future<FileSystemEntity> that completes with this FileSystemEntity
 * when the deletion is done. If the FileSystemEntity cannot be deleted, the
 * future completes with an exception.
 * @description Checks that if the FileSystemEntity cannot be deleted, the
 * future completes with an exception.
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";
import "../../../Utils/async_utils.dart";
import "../file_utils.dart";

main() {
  Directory target = getTempDirectorySync();
  Link link = getTempLinkSync(target: target.path);
  link.deleteSync();

  asyncStart();
  link.delete(recursive: true).then((deleted) {
    Expect.fail("FileSystemException expected");
  }, onError: (e) {
    Expect.isTrue(e is FileSystemException);
    asyncEnd();
  }).whenComplete(() {
    target.delete();
  });
}