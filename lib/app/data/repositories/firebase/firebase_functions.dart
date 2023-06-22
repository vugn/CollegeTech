import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:teknisi_app/app/domain/entities/universities/university_entity.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/indicator.dart';
import '../../constants.dart';

class FirebaseFunctions {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  RxBool isLoading = false.obs;

  Future<void> createTechnicianUserCredential({
    required String fullName,
    required int accountType,
    required String phoneNumber,
    required String birth,
    required List<File> certificates,
    required List<File> ktms,
    required String skillDescription,
    required String address,
    required String university,
    required File profilePhoto,
    required String email,
    required String fileCertificateExt,
  }) async {
    try {
      List<Future<String>> certificateList = certificates
          .map((e) async => await uploadCertificatesTechnician(
              file: e,
              uid: _auth.currentUser!.uid,
              fileExt: fileCertificateExt))
          .toList();
      List<Future<String>> ktmList = ktms
          .map((e) async =>
              await uploadKtmsTechnician(file: e, uid: _auth.currentUser!.uid))
          .toList();
      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({
        "accountType": accountType,
        "uid": _auth.currentUser!.uid,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "birth": birth,
        "certificates": await Future.wait(certificateList),
        "ktms": await Future.wait(ktmList),
        "address": address,
        "skills_desc": skillDescription,
        "university": university,
        "skills": [],
        "profilePhoto": await uploadProfilePicture(
            file: profilePhoto,
            isTechnician: true,
            uidName: _auth.currentUser!.uid),
        "email": email
      }).then((value) async {
        await _auth.currentUser!.updateDisplayName(fullName);
        Indicator.closeLoading();
        Get.offAllNamed(Routes.MAIN);
      });
    } catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e);
      }
      showAlert(e.toString());
    }
  }

  Future<void> createUserCredential({
    required String fullName,
    required String phoneNumber,
    required int accountType,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({
        "uid": _auth.currentUser!.uid,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "accountType": accountType,
        "email": email
      }).then((value) async {
        await _auth.currentUser!.updateDisplayName(fullName);
        Indicator.closeLoading();
        Get.offAndToNamed(Routes.MAIN);
      });
    } catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e);
      }
      showAlert(e.toString());
    }
  }

  Future<void> createUserAddress(String address, String latlng) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({"address": address, "latlng": latlng});
    } catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> getUserTypeExist(
      {required String email, required int accountType}) async {
    try {
      QuerySnapshot user = await _firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('accountType', isEqualTo: accountType)
          .get();
      if (user.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future<QuerySnapshot?> getUserCredential(String email) async {
    try {
      QuerySnapshot user = await _firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (user.docs.isNotEmpty) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<bool> getEmailDuplicate({required String email}) async {
    QuerySnapshot getEmail = await _firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (getEmail.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getPhoneNumberDuplicate({required String phoneNumber}) async {
    QuerySnapshot getPhoneNumber = await _firebaseFirestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    if (getPhoneNumber.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<UniversityEntity>> getUniversities() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> getUniversities =
          await _firebaseFirestore
              .collection('universities')
              .doc('banjarmasin')
              .get();
      List? data = getUniversities.data()?.values.toList()[0];
      List? universities = data?.map((e) => e).toList();
      return universities?.map((e) => UniversityEntity.fromJson(e)).toList() ??
          [const UniversityEntity(name: '', value: '')];
    } catch (e) {
      showAlert("$e");
      return [const UniversityEntity(name: '', value: '')];
    }
  }

  Future<List<String>> getSkills() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> getSkills =
          await _firebaseFirestore.collection('skills').doc('skills').get();
      List<dynamic> data = getSkills.data()!.values.toList()[0];
      return data.map((e) => e.toString()).toList();
    } catch (e) {
      showAlert("$e");
      return [''];
    }
  }

  Future<String> uploadProfilePicture(
      {required File file,
      required bool isTechnician,
      required String uidName}) async {
    try {
      var refrence = _storage
          .ref()
          .child(isTechnician
              ? 'images/profiles/technicians/'
              : '/images/profiles/users/')
          .child("/$uidName.jpg");
      await refrence.putFile(file);

      return refrence.getDownloadURL();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showAlert("$e");
      return "";
    }
  }

  Future<String> uploadCertificatesTechnician(
      {required File file,
      required String uid,
      required String fileExt}) async {
    try {
      String imageName = generateId();

      Reference refrence = _storage
          .ref()
          .child('images/certificates/technicians/$uid/')
          .child("/$imageName.$fileExt");

      await refrence.putFile(file);
      return refrence.getDownloadURL();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showAlert("$e");
      return '';
    }
  }

  Future updateCertificatesTechnician(String uid, List<String> files) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .update({'certificates': FieldValue.arrayUnion(files)});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future deleteCertificatesTechnician(String uid, String file) async {
    try {
      Reference reference = _storage
          .ref()
          .child('images/certificates/technicians/$uid/')
          .child('/${getFileName(file, true)}');
      await _firebaseFirestore.collection('users').doc(uid).update({
        'certificates': FieldValue.arrayRemove([file])
      });
      await reference.delete();
    } catch (e) {
      Indicator.closeLoading();
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future updateSkillsTechnician(String uid, List<String> skills) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .update({'skills': FieldValue.arrayUnion(skills)});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future deleteSkillTechnician(String uid, String skill) async {
    try {
      await _firebaseFirestore.collection('users').doc(uid).update({
        'skills': FieldValue.arrayRemove([skill])
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String> uploadKtmsTechnician(
      {required File file, required String uid}) async {
    try {
      String imageName = generateId();

      Reference refrence = _storage
          .ref()
          .child('images/ktms/technicians/$uid/')
          .child("/$imageName.jpg");

      await refrence.putFile(file);
      return refrence.getDownloadURL();
    } catch (e) {
      showAlert("$e");
      return "";
    }
  }

  Future<List<String>> getCertificateList(String uid) async {
    try {
      ListResult reference = await _storage
          .ref()
          .child('images/certificates/technicians/$uid/')
          .listAll();
      return await Future.wait(
          reference.items.map((e) => e.getDownloadURL()).toList());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
//   Future<void> uploadBlog(String title, String description, File image) async {
//     try {
//       String id = generateId();
//       DateTime time = DateTime.now();

//       String imageUrl = await uploadImage(image);

//       Map<String, dynamic> blogDetails = {
//         'id': id,
//         'title': title,
//         'description': description,
//         'img': imageUrl,
//         'time': time,
//       };

//       await _firebaseFirestore
//           .collection('blogs')
//           .doc(id)
//           .set(blogDetails)
//           .then((value) {
//         saveDataToMyBlogs(id);
//       });
//     } catch (e) {
//       showAlert("$e");
//     }
//   }

//   Future<List<BlogsModel>> getBlogs() async {
//     if (_hasMoreData) {
//       if (!isLoading.value) {
//         try {
//           if (_lastDocument == null) {
//             return await _firebaseFirestore
//                 .collection('blogs')
//                 .orderBy('time')
//                 .limit(_documentLimit)
//                 .get()
//                 .then((value) {
//               _lastDocument = value.docs.last;

//               if (value.docs.length < _documentLimit) {
//                 _hasMoreData = false;
//               }

//               Indicator.closeLoading();

//               return value.docs
//                   .map((e) => BlogsModel.fromJson(e.data()))
//                   .toList();
//             });
//           } else {
//             isLoading.value = true;

//             return await _firebaseFirestore
//                 .collection("blogs")
//                 .orderBy('time')
//                 .startAfterDocument(_lastDocument!)
//                 .limit(_documentLimit)
//                 .get()
//                 .then((value) {
//               _lastDocument = value.docs.last;

//               if (value.docs.length < _documentLimit) {
//                 _hasMoreData = false;
//               }

//               isLoading.value = false;

//               return value.docs
//                   .map((e) => BlogsModel.fromJson(e.data()))
//                   .toList();
//             });
//           }
//         } catch (e) {
//           showAlert("$e");
//           print(e.toString());
//           return [];
//         }
//       } else {
//         return [];
//       }
//     } else {
//       print("No More Data");
//       return [];
//     }
//   }

//   Future<void> saveDataToMyBlogs(String id) async {
//     try {
//       await _firebaseFirestore
//           .collection('users')
//           .doc(_auth.currentUser!.uid)
//           .collection('myblos')
//           .doc(id)
//           .set({
//         'id': id,
//       });
//     } catch (e) {
//       showAlert("$e");
//     }
//   }

//   Future<List> getMyBlogs() async {
//     try {
//       var snapshot = await _firebaseFirestore
//           .collection('users')
//           .doc(_auth.currentUser!.uid)
//           .collection("myblos")
//           .get();

//       return snapshot.docs.map((e) => e.data()['id']).toList();
//     } catch (e) {
//       showAlert("$e");
//       return [];
//     }
//   }

//   Future<BlogsModel> getBlogsById(String id) async {
//     try {
//       var documentSnapshot =
//           await _firebaseFirestore.collection('blogs').doc(id).get();

//       return BlogsModel.fromJson(documentSnapshot.data()!);
//     } catch (e) {
//       showAlert("$e");
//       return BlogsModel(description: "", title: "", id: "", image: "");
//     }
//   }

//   Future<void> deleteBlog(String id) async {
//     await Future.wait([
//       deleteMyBlog(id),
//       deletePublicBlog(id),
//     ]);
//   }

//   Future<void> deletePublicBlog(String id) async {
//     try {
//       await _firebaseFirestore.collection('blogs').doc(id).delete();
//     } catch (e) {
//       showAlert("$e");
//     }
//   }

//   Future<void> deleteMyBlog(String id) async {
//     try {
//       await _firebaseFirestore
//           .collection('users')
//           .doc(_auth.currentUser!.uid)
//           .collection('myblos')
//           .doc(id)
//           .delete();
//     } catch (e) {
//       showAlert("$e");
//     }
//   }

//   Future<void> editBlog(String id, Map<String, dynamic> map) async {
//     try {
//       await _firebaseFirestore.collection('blogs').doc(id).update(map);
//     } catch (e) {
//       showAlert("$e");
//     }
//   }

//   Future<void> addToFavourite(String id) async {
//     try {
//       await _firebaseFirestore
//           .collection("users")
//           .doc(_auth.currentUser!.uid)
//           .collection('favourite')
//           .doc(id)
//           .set({
//         'id': id,
//       });
//     } catch (e) {
//       showAlert("$e");
//     }
//   }

//   Future<List> getFavouriteList() async {
//     try {
//       var querySnapshot = await _firebaseFirestore
//           .collection('users')
//           .doc(_auth.currentUser!.uid)
//           .collection('favourite')
//           .get();

//       return querySnapshot.docs.map((e) => e.data()['id']).toList();
//     } catch (e) {
//       showAlert("$e");
//       return [];
//     }
//   }

//   Future<void> deleteFromFavorite(String id) async {
//     try {
//       await _firebaseFirestore
//           .collection('users')
//           .doc(_auth.currentUser!.uid)
//           .collection('favourite')
//           .doc(id)
//           .delete();
//     } catch (e) {
//       showAlert("$e");
//     }
//   }
// }
