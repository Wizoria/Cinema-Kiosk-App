import 'package:flutter/material.dart';
import '../../../models/check_model.dart';
import '../../../models/nomenclature_group.dart';
import '../../../models/nomenclature_item.dart';
import '../../../models/seat.dart';
import '../../../models/total_item.dart';
import '../ticket_booking/ticket_booking_model.dart';

class CinemarketModel extends ChangeNotifier {
  static CinemarketModel? _cinemarketModel;

  CinemarketModel._internal();

  factory CinemarketModel() {
    _cinemarketModel ??= CinemarketModel._internal();
    return _cinemarketModel!;
  }

  int currentIndex = 0;

  List<NomenclatureGroup> nomenclature = [];

  late List<NomenclatureItem> currentNomenclature =
      nomenclature[0].nomenclatureItem;

  List<TotalItem> selectedProducts = [];

  void callbackButtonCurrentIndex(int index) {
    currentIndex = index;
    currentNomenclature = nomenclature[currentIndex].nomenclatureItem;
    notifyListeners();
  }

  getAmount(int id) {
    if (selectedProducts.isNotEmpty) {
      bool found = false;
      for (TotalItem check in selectedProducts) {
        if (id == check.id) {
          found = true;
          return check.amount;
        }
      }
      if (!found) {
        return 0;
      }
    } else {
      return 0;
    }
  }

  void callbackNomenclature(bool increment, int id, String name, double price) {
    if (selectedProducts.isNotEmpty) {
      bool found = false;
      for (TotalItem check in selectedProducts) {
        if (id == check.id) {
          if (increment) {
            found = true;
            check.totalPrice = check.price * ++check.amount;
          } else {
            if (--check.amount == 0) {
              selectedProducts.remove(check);
              break;
            } else {
              check.totalPrice = (check.price * check.amount);
            }
          }
        }
      }
      if (!found && increment) {
        selectedProducts.insert(
            0,
            TotalItem(
                id: id,
                name: name,
                price: price,
                totalPrice: price,
                amount: 1));
      }
    } else {
      if (increment) {
        selectedProducts.add(TotalItem(
            id: id, name: name, price: price, totalPrice: price, amount: 1));
      }
    }
    CheckModel().updateCheck();
    notifyListeners();
  }

  void removeNomenclatureGlasses() {
    for (TotalItem check in selectedProducts) {
      if (777 == check.id) {
        selectedProducts.remove(check);
        notifyListeners();
        break;
      }
    }
    CheckModel().updateCheck();
  }

  void removeNomenclature(int id) {
    for (TotalItem check in selectedProducts) {
      if (id == check.id) {
        selectedProducts.remove(check);
        if (id == 777) {
          for (Seat seat in TicketBookingModel().selectedSeats) {
            if (seat.priceGlasses > 0) {
              seat.priceGlasses = 0;
            }
          }
        }
        notifyListeners();
        break;
      }
    }
    CheckModel().updateCheck();
  }

  resetSelectedNomenclature() {
    selectedProducts.clear();
    notifyListeners();
  }
}

class CinemarketBanner {
  String image = '';

  CinemarketBanner({
    required this.image,
  });

  factory CinemarketBanner.fromJson(Map<String, dynamic> json) {
    return CinemarketBanner(
      image: json['image'] as String,
    );
  }

  @override
  String toString() {
    return 'CinemarketBanner{name: $image}';
  }

  CinemarketBanner.empty() {
    image = 'Empty';
  }
}
