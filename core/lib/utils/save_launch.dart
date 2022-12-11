import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$fileName');

  await file.writeAsBytes(bytes);

  await OpenFile.open(file.path);
}
