import '../ui/screens/ticket_booking/ticket_booking_model.dart';

class Seat {
  int row = 0;
  int seat = 0;
  String status = '';
  int priceK = 0;
  bool seatVIP = false;
  int priceGlasses = 0;
  String promoCode = '';

  SeatMapCoordinates seatMapCoordinates = SeatMapCoordinates(0, 0, 0.0, 0.0, 0.0);

  Seat({
    required this.row,
    required this.seat,
    required this.status,
    required this.priceK,
    required this.seatVIP,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      row: json['row'] as int,
      seat: json['seat'] as int,
      status: json['status'] as String,
      priceK: json['priceK'] as int,
      seatVIP: json['seatVIP'] as bool,
    );
  }

  Seat.empty() {
    row = 0;
    seat = 0;
    status = '';
    priceK = 0;
    seatVIP = false;
    priceGlasses = 0;
    promoCode = '';
  }

  @override
  String toString() {
    return 'Seat{row: $row, seat: $seat, status: $status, priceK: $priceK, seatVIP: $seatVIP}';
  }
}
