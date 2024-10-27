import "package:dio/dio.dart";
import "package:note_hub/view/widgets/toasts.dart";
import "package:open_file/open_file.dart";
import "package:path_provider/path_provider.dart";

final dio = Dio();

Future<void> saveAndOpenFile(
    {required String uri, required String name}) async {
  var temporaryDirectory = await getTemporaryDirectory();
  var tmpPaths = uri.split("/");
  String code = tmpPaths[tmpPaths.length - 1];
  String savePath = "${temporaryDirectory.path}/${code}_$name";

  print("Save Path: $savePath");

  try {
    await dio.download(uri, savePath);
  } catch (error) {
    print("Error downloading file $uri");
    Toasts.showTostError(message: "Unable to open file");
  }
  OpenFile.open(savePath);

  temporaryDirectory;
}
