import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {

  Reference? profilePicRef;
  List<String> allUrls = [];

  @override
  void initState() {
    super.initState();
    getStorageImg();
  }

  void getStorageImg(){
    var ref = FirebaseStorage.instance.ref();
    
    profilePicRef = ref.child('images/profile_pic');
    getAllImgUrl();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Bucket'),
      ),
      body: allUrls.isNotEmpty ? ListView.builder(
          itemCount: allUrls.length,
          itemBuilder: (_, index){
            return Image.network(allUrls[index]);
          }) : Center(child: Text('No Images'),)
    );
  }

  void getAllImgUrl() async{
    var listData = await profilePicRef!.listAll();
    for(Reference eachRef in listData.items){
      var eachImgUrl = await eachRef.getDownloadURL();
      allUrls.add(eachImgUrl);
    }

    setState(() {

    });

  }
}
