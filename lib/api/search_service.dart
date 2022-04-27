import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  search(String searchField) {
    return FirebaseFirestore.instance
        .collection('jobs')
        .where('job_title',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
