import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

void showAlert(String message) {
  Fluttertoast.showToast(msg: message);
}

String generateId() {
  return const Uuid().v1();
}

String getFileName(String url, bool withUid) {
  RegExp regExp = RegExp(r'.+(\/|%2F)(.+)\?.+');
  Iterable<RegExpMatch> matches = regExp.allMatches(url);

  RegExpMatch match = matches.elementAt(0);
  String withUidResult = Uri.decodeFull(match.group(2)!);
  String withoutUidResult =
      '${withUidResult.split('.')[1]}.${withUidResult.split('.')[2]}';
  if (withUid) {
    return withUidResult;
  } else {
    return withoutUidResult;
  }
}
