import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload image to Firebase Storage
  Future<String?> uploadImage(File imageFile) async {
    try {
      final ref = _storage
          .ref()
          .child('item_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Image upload failed: $e');
      return null;
    }
  }

  // Add lost or found report to Firestore
  Future<void> addReport({
    required bool isLost,
    required String name,
    required String item,
    required String contact,
    required String location,
    required String description,
    required DateTime? date,
    String? imageUrl,
  }) async {
    try {
      // current user ko get krien
      final user= FirebaseAuth.instance.currentUser;
      if (user==null){
        throw Exception("User not logged in");
      }
      final data = {
        'userId':user.uid, //UID add krien
        'name': name,
        'item': item,
        'contact': contact,
        'location': location,
        'description': description,
        'date': date?.toIso8601String(),
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      };

      final collection = isLost ? 'lost_items' : 'found_items';
      await _firestore.collection(collection).add(data);
    } catch (e) {
      print('Firestore addReport failed: $e');
      rethrow;
    }
  }
  //ider se agay change kiya
  // Add to existing class
  Future<void> updateClaimStatus(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).update({
        'isClaimed': true,
        'claimerId': FirebaseAuth.instance.currentUser!.uid,
        'claimedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Claim update failed: $e');
      rethrow;
    }
  }
  // yahan se pehle tak
}
