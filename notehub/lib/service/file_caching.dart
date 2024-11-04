import "dart:io";

import "package:dio/dio.dart";

import "package:path_provider/path_provider.dart";

import "package:notehub/view/widgets/toasts.dart";

final dio = Dio();

Future<String> saveAndOpenFile(
    {required String uri, required String name}) async {
  var temporaryDirectory = await getTemporaryDirectory();
  var tmpPaths = uri.split("/");
  String code = tmpPaths[tmpPaths.length - 1];
  String savePath = "${temporaryDirectory.path}/${code}_$name";

  print("Save Path: $savePath");

  if (await ifFileExists(savePath)) {
    return savePath;
  }

  try {
    await dio.download(uri, savePath);
  } catch (error) {
    print("Error downloading file $uri");
    Toasts.showTostError(message: "Unable to open file");
  }

  return savePath;
}

Future<bool> ifFileExists(path) async {
  var file = File(path);
  if (await file.exists()) {
    return true;
  }

  return false;
}
