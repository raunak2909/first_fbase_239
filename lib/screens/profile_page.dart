import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? actualImg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () async {
              /// Image picker
              var picker = ImagePicker();
              XFile? pickedImg =
                  await picker.pickImage(source: ImageSource.camera);

              if (pickedImg != null) {
                var cropper = ImageCropper();

                CroppedFile? croppedImg = await cropper.cropImage(sourcePath: pickedImg.path, aspectRatioPresets: [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio16x9,
                  CropAspectRatioPreset.ratio5x4,
                ], uiSettings: [
                  AndroidUiSettings(
                    toolbarTitle: 'Crop your picture',
                    toolbarColor: Colors.deepOrange,
                    toolbarWidgetColor: Colors.white,
                    initAspectRatio: CropAspectRatioPreset.square,
                  ),
                  IOSUiSettings(
                    title: 'Cropper',
                  ),
                  WebUiSettings(
                    context: context,
                  ),
                ]);

                actualImg = File(croppedImg!.path);
                setState(() {

                });
              }

              /// Image Cropper
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: actualImg!=null ? DecorationImage(
                  image: FileImage(actualImg!)
                ) : DecorationImage(image: NetworkImage("https://static.vecteezy.com/system/resources/previews/003/718/594/original/avatar-contact-media-free-vector.jpg"))
              ),
            ),
          ),
          /*SizedBox(
            height: 11,
          ),
          ElevatedButton(onPressed: (){
            /// Image picker
            /// Image Cropper
          }, child: Text('Choose Image')),*/
          SizedBox(
            height: 11,
          ),
          ElevatedButton(
              onPressed: () {
                /// Image upload
                var timeStamp = DateTime.now().millisecondsSinceEpoch;
                var ref = FirebaseStorage.instance.ref().child("images/profile_pic/IMG_$timeStamp.jpg");

                ref.putFile(actualImg!)
                    .then((value) async{
                      print("Image uploaded successfully!!");
                      var imgUrl = await value.ref.getDownloadURL();
                      
                      FirebaseFirestore.instance.collection("users").doc("MDhfuDfJL0hzjGAqppHTxU1G2TR2").update({
                        "profile_pic" : imgUrl
                      });
                })
                    .onError((error, stackTrace) {
                      print("Error: ${error.toString()}");
                });
                
              },
              child: Text('Upload Image'))
        ],
      ),
    );
  }
}
