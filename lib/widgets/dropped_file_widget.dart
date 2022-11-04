import 'package:flutter/material.dart';
import 'package:hospal/constants/style.dart';

import '../classes/dropped_file.dart';

class DroppedFileWidget extends StatelessWidget {
  final DroppedFile file;

  const DroppedFileWidget({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) => buildFilePreview();

  Widget buildFilePreview() {
    // ignore: unnecessary_null_comparison
    var preview = (file != null)
        // ignore: avoid_unnecessary_containers
        ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: light,
                        border: Border.all(width: 5, color: midOrange)),
                    child: buildImage()),
                // ignore: unnecessary_null_comparison
                if (file != null) buildFileDetails(file),
              ],
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.no_sim,
                  color: light,
                  size: 42,
                ),
                Text(
                  'No files selected.',
                  style: TextStyle(color: light, fontSize: 18),
                ),
              ],
            ),
          );
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            height: 200,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: darkOrange),
            child: preview));
  }

  Widget buildFileDetails(DroppedFile file) {
    const style = TextStyle(fontSize: 16);
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              /* 'OneStop Firm Fee Statement 18-2-19', */
              file.name,
              style: style.copyWith(fontWeight: FontWeight.bold, color: light)),
          y10,
          Text(
              /* 'PDF Document', */
              file.mime,
              style: style.copyWith(
                  /* fontWeight: FontWeight.bold,*/ color: light)),
          y10,
          Text(
              /* '45.07 MB', */
              file.formattedSize,
              style: style.copyWith(
                  /* fontWeight: FontWeight.bold, */ color: light)),
        ],
      ),
    );
  }

  Widget buildImage() {
    // ignore: unnecessary_null_comparison
    if (file == null) return buildEmptyFile('No File');

    return Image.network(
      file.url,
      width: 120,
      height: 120,
      fit: BoxFit.scaleDown,
      errorBuilder: (context, error, _) =>
          buildEmptyFile('Preview Unavailable'),
    );
  }

  Widget buildEmptyFile(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: midOrange, fontSize: 16),
      ),
    );
  }
}
