import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:cinema_kiosk_app/models/tag_marker.dart';

class Session {
  int id = 0;
  String format = '';
  DateTime date = DateTime.parse("2022-12-01 00:00:00");
  String timeStart = '';
  String timeEnd = '';
  bool available = false;
  bool allowedBuy = false;
  bool isVip = false;
  bool is2D = false;
  bool is3D = false;
  bool is4DX = false;
  bool isAtmos = false;
  bool isLaser = false;
  String stringStatusSeat = '';
  bool numberingRightToLeft = false;
  int hallNumber = 0;
  int glassPrice = 0;
  int price = 0;
  int priceVIP = 0;
  bool isServiceSession = false;
  List<TagMarker> tags = [];

  String formatString = '';
  String dateString = '';

  int movieId = 0;
  String movieTitle = '';
  String movieGenre = '';
  String movieAge = '';
  String movieImageRef = '';

  Session({
    required this.id,
    required this.format,
    required this.date,
    required this.timeStart,
    required this.available,
    required this.allowedBuy,
    required this.isVip,
    required this.is2D,
    required this.is3D,
    required this.is4DX,
    required this.isAtmos,
    required this.isLaser,
    required this.stringStatusSeat,
    required this.numberingRightToLeft,
    required this.hallNumber,
    required this.glassPrice,
    required this.price,
    required this.priceVIP,
    required this.isServiceSession,
    required this.formatString,
    // required this.dateString,
    this.tags = const [],
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    DateTime sessionDate = getDateFromString(json['date']);

    final tags = <TagMarker>[];

    bool is2D = false;
    bool is3D = false;
    bool is4DX = false;
    bool isAtmos = false;
    bool isLaser = false;
    bool isVip = false;
    if (json['tags'] != null) {
      json['tags'].forEach((v) {
        tags.add(TagMarker.fromJson(v));
        if (TagMarker.fromJson(v).tagName == '2D') {
          is2D = true;
        } else if (TagMarker.fromJson(v).tagName == '3D') {
          is3D = true;
        } else if (TagMarker.fromJson(v).tagName == '4DX') {
          is4DX = true;
        } else if (TagMarker.fromJson(v).tagName == 'Atmos') {
          isAtmos = true;
        } else if (TagMarker.fromJson(v).tagName == 'Laser') {
          isLaser = true;
        }
        if (TagMarker.fromJson(v).tagType == 'vip') {
          isVip = true;
        }
      });
    }

    String isFormat = '';

     if (isLaser) {
      isFormat = ' | Laser';
    } else if (is4DX) {
      isFormat = ' | 4DX';
    } else if (isAtmos) {
      isFormat = ' | 48 FPS | Atmos';
    }

    String formatString = isFormat;

    // String is4DXString = '';
    // if (is4DX == true) {
    //   is4DXString = '4DX';
    // }
    // String isVipString = '';
    // if (isVip == true && AppManager().cinemaSettings.cinemaChainId == 1) {
    //   isVipString = 'VIP';
    // } else if (isVip == true && AppManager().cinemaSettings.cinemaChainId == 2) {
    //   isVipString = 'LUX';
    // }
    // String formatString = json['format'];
    // if (is4DXString != '') {
    //   formatString = '$formatString $is4DXString';
    // }
    // if (isVipString != '') {
    //   formatString = '$formatString $isVipString';
    // }

    return Session(
      id: json['id'] as int,
      format: json['format'] as String,
      date: sessionDate,
      timeStart: json['timeStart'] as String,
      available: json['available'] as bool,
      allowedBuy: json['allowedBuy'] as bool,
      isVip: isVip,
      is2D: is2D,
      is3D: is3D,
      is4DX: is4DX,
      isAtmos: isAtmos,
      isLaser: isLaser,
      stringStatusSeat: json['stringStatusSeat'] as String,
      numberingRightToLeft: json['numberingRightToLeft'] as bool,
      hallNumber: json['hallNumber'] as int,
      glassPrice: json['glassPrice'] as int,
      price: json['price'] as int,
      priceVIP: json['priceVIP'] as int,
      isServiceSession: json['isServiceSession'] as bool,
      formatString: formatString,
      tags: tags,
    );
  }

  Session.empty() {
    id = 0;
    format = '';
    date = DateTime.parse("2022-12-01 00:00:00");
    timeStart = '';
    available = false;
    allowedBuy = false;
    isVip = false;
    is2D = false;
    is3D = false;
    is4DX = false;
    isAtmos = false;
    isLaser = false;
    stringStatusSeat = '';
    numberingRightToLeft = false;
    hallNumber = 0;
    glassPrice = 0;
    price = 0;
    priceVIP = 0;
    isServiceSession = false;
    tags = [];

    formatString = '';
    dateString = '';

    movieId = 0;
    movieTitle = 'Session not found';
    movieGenre = '';
    movieImageRef = '';
  }

  @override
  String toString() {
    return 'Session{id: $id, format: $format, date: $date, timeStart: $timeStart, tags: $tags}';
  }
}
