import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneaker_store/models/objects.dart';

// -----> This class represents the UsersController, which is responsible for interacting with the Firestore database and fetching data related to users and enrolled products.

class UsersController {
  // -----> Reference to the 'users' collection in Firestore.
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // -----> Reference to the 'enrolled' collection in Firestore.
  CollectionReference enrolled =
      FirebaseFirestore.instance.collection('enrolled');

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

  // -----> Fetches a list of EnrolledModel objects representing enrolled products.
  Future<List<EnrolledModel>> getEnrolled() async {
    try {
      // -----> Query for fetching all enrolled product data from Firestore.
      QuerySnapshot snapshot = await enrolled.get();

      // -----> List to store EnrolledModel objects.
      List<EnrolledModel> list = [];

      // -----> Loop through the fetched data and map it to EnrolledModel objects.
      for (var element in snapshot.docs) {
        // -----> Mapping each fetched document to an EnrolledModel object.
        EnrolledModel model =
            EnrolledModel.fromJson(element.data() as Map<String, dynamic>);
        // -----> Adding the EnrolledModel object to the list.
        list.add(model);
      }

      // -----> Return the list of EnrolledModel objects.
      return list;
    } catch (e) {
      // -----> If an error occurs during the process, print the error and return an empty list.
      // ignore: avoid_print
      print(e);
      return [];
    }
  }
}
