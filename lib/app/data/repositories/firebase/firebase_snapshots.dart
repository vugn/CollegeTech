import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';

class FirebaseSnapshots {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuthentication _authentication = FirebaseAuthentication();

  Stream<DocumentSnapshot> getUserCredentialSnapshot() {
    String? uid = _authentication.currentUser()!.uid;
    Stream<DocumentSnapshot> userSnapshot =
        _firebaseFirestore.collection('users').doc(uid).snapshots();
    print(userSnapshot);
    return userSnapshot;
  }
}
