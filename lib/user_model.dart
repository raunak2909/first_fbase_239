class UserModel {
  String? name;
  String? email;
  String? gender;
  String? address;
  int? age;
  String? mobNo;

  UserModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.address,
    required this.age,
    required this.mobNo,
  });

  factory UserModel.fromDoc(Map<String, dynamic> doc){
    return UserModel(
        name: doc['name'],
        email: doc['email'],
        gender: doc['gender'],
        address: doc['address'],
        age: doc['age'],
        mobNo: doc['mobNo']);
  }


  Map<String, dynamic> toDoc() {
    return {
      "name": name,
      "email": email,
      "gender": gender,
      "address": address,
      "age": age,
      "mobNo": mobNo,
    };
  }
}
