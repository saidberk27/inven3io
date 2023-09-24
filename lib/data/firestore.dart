import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  Future<void> addDocument(
      {required String collectionPath,
      required Map<String, dynamic> document}) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionPath);
    await collection
        .add(document)
        .then((value) => print("Document added with $value"));
  }

  void addDocumentWithCustomID(
      {required String collectionPath,
      required String customID,
      required Map<String, dynamic> document}) {
    FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(customID)
        .set(document)
        .then((_) {
      print('Document added with custom ID: $customID');
    }).catchError((error) {
      print('Error adding document: $error');
    });
  }

  Future<Map<String, dynamic>> readSingleDocument(
      {required String collectionPath, required String documentID}) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionPath);
    DocumentSnapshot documentSnapshot = await collection.doc(documentID).get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>;
    } else {
      return {"status": "no file found"};
    }
  }

  Future<Map<String, dynamic>> readDocumentsWithLatestTimestamp(
      {required String collectionPath}) async {
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(collectionPath);

      QuerySnapshot querySnapshot =
          await collectionRef.orderBy("timeStamp", descending: true).get();

      List<Map<String, dynamic>> documentsData = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return documentsData[0]; // lastReport
    } catch (error) {
      print('Error reading documents with latest timestamp: $error');
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> readDocumentsOfCollection(
      {required String collectionPath}) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionPath);

    QuerySnapshot querySnapshot = await collection.get();
    List<Map<String, dynamic>> data = [];

    querySnapshot.docs.forEach((doc) {
      data.add(doc.data() as Map<String, dynamic>);
    });

    return data;
  }

  Future<List<Map<String, dynamic>>> readDocumentsOfCollectionByTime({
    required String collectionPath,
  }) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionPath);

    QuerySnapshot querySnapshot =
        await collection.orderBy('timeStamp', descending: true).get();

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

  Future<void> removeDocument(
      {required String collectionPath, required String documentID}) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionPath);
    await collection.doc(documentID).delete().then((value) {
      print("Document deleted.");
    });
  }
}
