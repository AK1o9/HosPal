import 'dart:typed_data';

class DroppedFile {
  final String url;
  final String name;
  final String mime;
  final int size;
  final Uint8List bytes;

  const DroppedFile({
    required this.url,
    required this.name,
    required this.mime,
    required this.size,
    required this.bytes,
  });

  String get formattedSize {
    final kb = size / 1024;
    final mb = kb / 1024;

    return mb > 1
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}
