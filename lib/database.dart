import 'package:firebase_database/firebase_database.dart';

// FirebaseDatabase database = FirebaseDatabase.instance;

// DatabaseReference ref = FirebaseDatabase.instance.ref();

// class Message {
//   final String uid;
//   final String message;

//   const Message({
//     @required this.userId,
//     @required this.message,
//   });

//   static Message fromJson(Map<String, dynamic> json) => Message(
//         userId: json['idUser'],
//         message: json['message'],
//       );

//   Map<String, dynamic> toJson() => {
//         'idUser': userId,
//         'message': message,
//       };
// }

Future<dynamic> setData(String uid) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/${uid}');

  await ref.set({
    'Disciplina A': {
      'id': 1,
      'name': 'Disciplina A',
      'timeCourse': '1º período',
      'isSelected': true
    },
    'Disciplina B': {
      'id': 2,
      'name': 'Disciplina B',
      'timeCourse': '1º período',
      'isSelected': true
    },
    'Disciplina C': {
      'id': 3,
      'name': 'Disciplina C',
      'timeCourse': '1º período',
      'isSelected': false
    },
    'Disciplina D': {
      'id': 4,
      'name': 'Disciplina D',
      'timeCourse': '1º período',
      'isSelected': false
    },
    'Disciplina E': {
      'id': 5,
      'name': 'Disciplina E',
      'timeCourse': '1º período',
      'isSelected': false
    },
  });
}

Future<Map<String, dynamic>> getData(String uid) async {
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('users/$uid').get();
  var data;
  if (snapshot.exists) {
    // print(snapshot.value);
    // final data = Map<String, dynamic>.from(snapshot.value as Map);
    data = Map<String, dynamic>.from(snapshot.value as Map);
    // print(snapshot.value);
  } else {
    data = Map<String, dynamic>.from({});
    // print('No data available.');
  }
  // print('diferenca');
  // print(data);
  return data;
}

void updateData(String uid, dynamic data) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/${uid}');
  print('cheguei');
  print(data);
  // print(data[0]['name']);
  var map1 = Map.fromIterable(data, key: (e) => e['name'], value: (e) => e);
  print('AHHAHA');
  print(map1);
  await ref.set(map1);
}
