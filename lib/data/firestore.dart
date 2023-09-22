import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  Future<void> addDocument(
      String collectionPath, Map<String, dynamic> document) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionPath);
    await collection
        .add(document)
        .then((value) => print("Document added with $value"));
  }

  Future<List<Map<String, dynamic>>> readDocumentsOfCollection(
      String collectionPath) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionPath);

    QuerySnapshot querySnapshot = await collection.get();
    List<Map<String, dynamic>> data = [];

    querySnapshot.docs.forEach((doc) {
      data.add(doc.data() as Map<String, dynamic>);
    });

    return data;
  }

  Future<void> updateDocument(String collectionPath, String documentID,
      Map<String, dynamic> updatedData) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionPath);
    await collection.doc(documentID).update(updatedData);
  }

  Future<void> deleteData(String collectionPath, String documentID) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionPath);
    await collection.doc(documentID).delete();
  }
}
