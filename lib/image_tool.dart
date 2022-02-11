import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

String _getMovieId(String str) {
  if (str.contains("youtube.com")) {
    List strList = str.split("v=");
    print(strList);
    return strList[1].substring(0, 11);
  } else if (str.contains("youtu.be")) {
    List strList = str.split("youtu.be/");
    return strList[1].substring(0, 11);
  } else {
    return "error";
  }
}

saveImage(String image) async {
  String imageUrl =
      "https://img.youtube.com/vi/" + _getMovieId(image) + "/maxresdefault.jpg";
  final url = Uri.parse(imageUrl);
  final response = await http.get(url);
  final bytes = response.bodyBytes;

  final temp = await getTemporaryDirectory();
  final path = "${temp.path}/nowplaying.jpg";
  File(path).writeAsBytesSync(bytes);
  return path;
}

void shareContents(List<String> imagePaths, String text) async {
  await Share.shareFiles(imagePaths, text: text);
}
