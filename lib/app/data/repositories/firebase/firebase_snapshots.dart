import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';

class FirebaseSnapshots {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuthentication _authentication = FirebaseAuthentication();

  Stream<DocumentSnapshot> getUserCredentialSnapshot() {
    String? uid = _authentication.currentUser()!.uid;
    Stream<DocumentSnapshot> userSnapshot =
        _firebaseFirestore.collection('users').doc(uid).snapshots();
    return userSnapshot;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrdersTechnicianSnapshot() {
    String? uid = _authentication.currentUser()!.uid;

    Stream<QuerySnapshot<Map<String, dynamic>>> ordersSnapshot =
        _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection('orders')
            .snapshots();
    return ordersSnapshot;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getBrandsSnapshot() {
    Stream<DocumentSnapshot<Map<String, dynamic>>> brandsSnapshot =
        _firebaseFirestore.collection('brands').doc('brands').snapshots();
    return brandsSnapshot;
  }
}
