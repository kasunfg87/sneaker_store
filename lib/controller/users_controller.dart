import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneaker_store/models/objects.dart';

class UsersController {
  // -----> Reference to the 'users' collection in Firestore.
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // -----> Fetches a list of UserModel objects representing all users.
  Future<List<UserModel>> getUsers() async {
    try {
      // -----> Query for fetching all user data from Firestore.
      QuerySnapshot snapshot = await users.get();

      // -----> List to store UserModel objects.
      List<UserModel> list = [];

      // -----> Loop through the fetched data and map it to UserModel objects.
      for (var element in snapshot.docs) {
        // -----> Mapping each fetched document to a UserModel object.
        UserModel model =
            UserModel.fromJson(element.data() as Map<String, dynamic>);
        // -----> Adding the UserModel object to the list.
        list.add(model);
      }

      // -----> Return the list of UserModel objects.
      return list;
    } catch (e) {
      // -----> If an error occurs during the process, print the error and return an empty list.
      // ignore: avoid_print
      print(e);
      return [];
    }
  }
}
