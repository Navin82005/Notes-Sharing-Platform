import 'dart:io';
import 'dart:typed_data';
import "package:path_provider/path_provider.dart";

Future<String> saveFile({required String filename, required data}) async {
  Uint8List binData = Uint8List.fromList(List<int>.from(data.toList()));
  final cacheDirectory = await getApplicationCacheDirectory();

  final filePath = "${cacheDirectory.path}/$filename";

  print("CACHE DIRECTORY PATH: ${cacheDirectory.path}");
  print("FILE PATH: $filePath");

  final newFile = File(filePath);
  await newFile.writeAsBytes(binData);

  return filePath;
}
