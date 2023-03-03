class PurchaseData {
  int cinemaId = 0;
  int certificate = 0;
  double cashback = 0;
  String lang = '';
  int phone = 0;
  String email = '';
  String clientId = '';
  String entryPoint = 'Kiosk';
  List<Tickets> tickets = [];
  List<Products> products = [];

  PurchaseData({
    required this.cinemaId,
    required this.certificate,
    required this.cashback,
    required this.lang,
    required this.phone,
    required this.email,
    required this.clientId,
    required this.entryPoint,
    required this.tickets,
    required this.products,
  });

  factory PurchaseData.fromJson(Map<String, dynamic> json) {
    final tickets = <Tickets>[];
    final products = <Products>[];

    if (json['tickets'] != null) {
      json['tickets'].forEach((v) {
        tickets.add(Tickets.fromJson(v));
      });
    }

    if (json['products'] != null) {
      json['products'].forEach((v) {
        products.add(Products.fromJson(v));
      });
    }

    return PurchaseData(
      cinemaId: json['cinemaId'] as int,
      certificate: json['certificate'] as int,
      cashback: json['cashback'] as double,
      lang: json['lang'] as String,
      phone: json['phone'] as int,
      email: json['email'] as String,
      clientId: json['clientId'] as String,
      entryPoint: json['entryPoint'] as String,
      tickets: tickets,
      products: products,
    );
  }

  Map<String, dynamic> toJson() => {
        'cinemaId': cinemaId,
        'certificate': certificate,
        'cashback': cashback,
        'lang': lang,
        'phone': phone,
        'email': email,
        'clientId': clientId,
        'entryPoint' : entryPoint,
        'cinema': tickets,
        'cinemarket': products,
      };

  PurchaseData.empty() {
    cinemaId = 0;
    certificate = 0;
    cashback = 0;
    lang = '';
    phone = 0;
    email = '';
    clientId = '';
    entryPoint = '';
    tickets = [];
    products = [];
  }

  @override
  String toString() {
    return 'PurchaseData{cinemaId: $cinemaId}';
  }
}

class Tickets {
  int row = 0;
  int place = 0;
  int sessionID = 0;
  int glass = 0;
  String promoCode = '';

  Tickets(
      {required this.row,
      required this.place,
      required this.sessionID,
      required this.glass,
      required this.promoCode});

  factory Tickets.fromJson(Map<String, dynamic> json) {
    return Tickets(
      row: json['row'] as int,
      place: json['place'] as int,
      sessionID: json['sessionID'] as int,
      glass: json['glass'] as int,
      promoCode: json['promoCode'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'row': row,
        'place': place,
        'sessionID': sessionID,
        'glass': glass,
        'promoCode': promoCode,
      };

  Tickets.empty() {
    row = 0;
    place = 0;
    sessionID = 0;
    glass = 0;
    promoCode = '';
  }
}

class Products {
  int id = 0;
  String name = '';
  String promoCode = '';

  Products({required this.id, required this.name, required this.promoCode});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'] as int,
      name: json['name'] as String,
      promoCode: json['promoCode'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'promoCode': promoCode,
      };

  Products.empty() {
    id = 0;
    name = '';
    promoCode = '';
  }
}
