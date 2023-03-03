import 'dart:developer';

class AdvertisingPoster {
  int id = 0;
  String title = '';
  String imageRef = '';
  int keyVal = 0;

  AdvertisingPoster({
    required this.id,
    required this.title,
    required this.imageRef,
    required this.keyVal,
  });

  factory AdvertisingPoster.fromJson(Map<String, dynamic> json) {
    String keyValString = json['keyVal'] ?? '';
    int keyVal = 0;
    try {
      keyVal = int.parse(keyValString);
    } catch (e) {
      log('Error in decoding KeyVal');
    }

    return AdvertisingPoster(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageRef: json['imageRef'] ?? '',
      keyVal: keyVal,
    );
  }

  @override
  String toString() {
    return 'AdvertisingPoster{id: $id, title: $title}';
  }
}
