import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../models/cinema.dart';
import '../../../repository/storage/cinema_preference.dart';
import '../../../service/app_manager.dart';

class SupportCinemasListElements extends StatefulWidget {
  final List<Cinema> cinemas;

  const SupportCinemasListElements({Key? key, required this.cinemas})
      : super(key: key);

  @override
  State<SupportCinemasListElements> createState() =>
      _SupportCinemasListElementsState();
}

class _SupportCinemasListElementsState
    extends State<SupportCinemasListElements> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.cinemas.length,
      itemBuilder: (context, index) {
        return RadioListTile(
          title: Text(widget.cinemas[index].title),
          value: widget.cinemas[index].id,
          groupValue: AppManager().cinemaSettings.cinemaId,
          onChanged: (void value) {
            AppManager().cinemaSettings.cinemaId = widget.cinemas[index].id;
            CinemaPreference cinemaPreference = CinemaPreference();
            cinemaPreference.setCinemaId(AppManager().cinemaSettings.cinemaId);
            cinemaPreference
                .setCinemaName(AppManager().cinemaSettings.cinemaName);
            setState(() {});
            log(AppManager().cinemaSettings.cinemaId.toString());
          },
        );
      },
    );
  }
}
