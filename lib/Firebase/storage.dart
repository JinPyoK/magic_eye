import 'package:firebase_storage/firebase_storage.dart';
import 'package:magic_eye/Firebase/auth.dart';

FirebaseStorage _storage = FirebaseStorage.instance;

Future<String> getStorageURL(String url) async {
  try {
    // String videoURL = await _storage
    //     .ref()
    //     .child('users')
    //     .child(getUID())
    //     .child(url)
    //     .getDownloadURL();
    String videoURL =
        await _storage.ref().child('videos').child(url).getDownloadURL();
    return videoURL;
  } on Exception catch (_) {
    return 'error';
  }
}
