import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

void showAlert(String message) {
  Fluttertoast.showToast(msg: message);
}

String generateId() {
  return const Uuid().v1();
}

String getFileName(String url) {
  RegExp regExp = RegExp(r'.+(\/|%2F)(.+)\?.+');
  //This Regex won't work if you remove ?alt...token
  var matches = regExp.allMatches(url);

  var match = matches.elementAt(0);
  // print("${Uri.decodeFull(match.group(2)!)}");
  return Uri.decodeFull(match.group(2)!);
}
