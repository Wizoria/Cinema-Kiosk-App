import 'package:cinema_kiosk_app/models/purchase_data.dart';
import 'package:cinema_kiosk_app/models/seat.dart';
import 'package:cinema_kiosk_app/models/total_item.dart';
import 'package:flutter/cupertino.dart';
import '../service/app_manager.dart';
import '../service/common_functions.dart';
import '../ui/screens/cinemarket/cinemarket_model.dart';
import '../ui/screens/ticket_booking/ticket_booking_model.dart';

class CheckModel with ChangeNotifier {
  static CheckModel? _checkModel;

  CheckModel._internal();

  factory CheckModel() {
    _checkModel ??= CheckModel._internal();
    return _checkModel!;
  }

  double _total = 0;

  String get total => removeTrailingZeros(_total); // VO Повертає String

  List<TotalItem> check = [];

  void updateCheck() {
    _total = 0;
    for (Seat seat in TicketBookingModel().selectedSeats) {
      if (seat.priceK > 0) {
        _total = _total + seat.priceK;
      }
    }
    for (TotalItem check in CinemarketModel().selectedProducts) {
      if (check.price > 0) {
        _total = _total + (check.price * check.amount);
      }
    }
    notifyListeners();
  }

  getCheckList() {
    check.clear();
    bool added = false;
    double price = 0;
    int amount = 0;
    for (Seat el in TicketBookingModel().selectedSeats) {
      if (!el.seatVIP && !added) {
        added = true;
        price = el.priceK.toDouble();
        amount++;
      } else if (!el.seatVIP) {
        amount++;
      }
    }
    if (added) {
      check.add(TotalItem(
          id: 0,
          name: 'Квитки',
          price: price,
          totalPrice: price * amount,
          amount: amount));
    }
    added = false;
    price = 0;
    amount = 0;
    for (Seat el in TicketBookingModel().selectedSeats) {
      if (el.seatVIP && !added) {
        added = true;
        price = el.priceK.toDouble();
        amount++;
      } else if (el.seatVIP) {
        amount++;
      }
    }
    if (added) {
      check.add(TotalItem(
          id: 0,
          name: 'Квитки LUX',
          price: price,
          totalPrice: price * amount,
          amount: amount));
    }
    added = false;
    price = 0;
    amount = 0;
    for (Seat el in TicketBookingModel().selectedSeats) {
      if (el.priceGlasses > 0 && !added) {
        added = true;
        price = el.priceGlasses.toDouble();
        amount++;
      } else if (el.priceGlasses > 0) {
        amount++;
      }
    }
    if (added) {
      check.add(TotalItem(
          id: 0,
          name: '3D-окуляри',
          price: price,
          totalPrice: price * amount,
          amount: amount));
    }

    for (TotalItem el in CinemarketModel().selectedProducts) {
      check.add(el);
    }

    return check;
  }

  formJsonFunction() {
    List<Tickets> tickets = [];
    List<Products> products = [];
    List<PurchaseData> purchaseData = [];
    for (Seat selectedSeat in TicketBookingModel().selectedSeats) {
      tickets.add(Tickets(
          row: selectedSeat.row,
          place: selectedSeat.seat,
          sessionID: TicketBookingModel().sessionId,
          glass: selectedSeat.priceGlasses > 0 ? 1 : 0,
          promoCode: 'promoCode'));
    }

    for (TotalItem selectedProduct in CinemarketModel().selectedProducts) {
      for (int i = 0; i < selectedProduct.amount; i++) {
        products.add(Products(
            id: selectedProduct.id,
            name: selectedProduct.name,
            promoCode: 'promoCode'));
      }
    }

    purchaseData.add(PurchaseData(
        cinemaId: AppManager().cinemaSettings.cinemaChainId,
        certificate: 0,
        cashback: 0,
        lang: AppManager().localizations,
        phone: 0,
        email: 'email',
        clientId: 'clientId',
        entryPoint: 'Kiosk',
        tickets: tickets,
        products: products));
    return purchaseData;
  }
}
