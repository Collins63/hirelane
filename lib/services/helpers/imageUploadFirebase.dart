import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FirebaseStorage _storage = FirebaseStorage.instance; 
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Imageuploadfirebase {
  Future<String> uploadImageToStorage(String childName , Uint8List file) async{
    try {
      Reference ref = _storage.ref().child(childName);
      UploadTask uploadTask = ref.putData(file);
      print('were here');
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e, stack) {
       print('Upload failed: $e');
      print('Stack trace: $stack');
      rethrow; // or return some fallback value or error string
    }
  }

  Future<String> saveData({required String firebaseId , required String email , required Uint8List file })async{
    String resp = "Some error occured";
    try {
      
      if(firebaseId.isNotEmpty || email.isNotEmpty || file.isNotEmpty){
        String imageUrl = await uploadImageToStorage('profileImages', file);
        
        await _firestore.collection('userProfile').add({
          'firebaseId': firebaseId,
          'email': email,
          'imageLink': imageUrl
        });
        resp = 'Success';
      }else{
        Get.snackbar("Error uploading image", "Details missing", 
          backgroundColor: Colors.red, 
          colorText: Colors.white,
          icon: Icon(Icons.error, color: Colors.white,)
        );
      }
    } catch (err) {
      resp = err.toString();
      print(resp);
    }
    return resp;
  }

}