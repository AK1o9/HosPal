import 'dart:io';
import 'dart:typed_data';
import '../classes/firebase_file.dart';
import 'package:universal_html/html.dart' as html;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException {
      return null;
    }
  }

  static UploadTask? uploadFolder(String folderName) {
    try {
      final ref = FirebaseStorage.instance.ref();

      return ref.child('files/$folderName/README.txt').putString("""
\t<<< This is an auto-generated file for the folder name, $folderName >>>\n
< It's not advised to delete/modify this file as that'd lead to the folder being removed permanently.>\n
""");
    } on FirebaseException {
      return null;
    }
  }

  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');
    await ref.writeToFile(file);
  }

  // ignore: missing_return, body_might_complete_normally_nullable
  static Future<File?> downloadFileOnWeb(FirebaseFile file) async {
    void downloadFile(String url) {
      html.AnchorElement anchorElement = html.AnchorElement(href: url);
      anchorElement.download = url;
      anchorElement.click();
    }

    downloadFile(file.url!);
  }

  static Future deleteFile(Reference ref) async {
    // final dir = await getApplicationDocumentsDirectory();

    // final file = File('${dir.path}/${ref.name}');

    // return ref.delete(file);
    return FirebaseStorage.instance.ref('files/${ref.name}').delete();
  }

  static Future deleteBytes(Reference ref) async {
    // try {
    //   final dir = await getApplicationDocumentsDirectory();
    // // ignore: empty_catches
    // } catch (e) {}

    return FirebaseStorage.instance.ref('files/${ref.name}').delete();
  }

  static Future updateFile(String destination, File file, Reference ref) async {
    //Upload (new file)
    uploadFile(destination, file);
    //Then delete (old file)
    deleteFile(ref);
  }

  // static Future openFile(File file) async {}
}
