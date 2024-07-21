import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> path() async {
  final Directory extDir = await getTemporaryDirectory();
  final testDir = await Directory('${extDir.path}/test').create(recursive: true);
  final String fileExtension = 'jpg';
  final String filePath = '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
  return filePath;
}
