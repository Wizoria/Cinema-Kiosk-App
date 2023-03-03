import 'dart:developer';

import 'package:cinema_kiosk_app/models/models.dart';
import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionFormatSelectionList extends StatefulWidget {
  const SessionFormatSelectionList({
    Key? key,
  }) : super(key: key);

  @override
  State<SessionFormatSelectionList> createState() =>
      _SessionFormatSelectionListState();
}

class _SessionFormatSelectionListState
    extends State<SessionFormatSelectionList> {
  @override
  Widget build(BuildContext context) {
    log('build SessionDateWidget');
    return Consumer<MoviesOnSale>(
      builder: (context, movie, child) {
        return SizedBox(
          height: adaptWidgetHeight(40),
          child: Row(
            children: [
              MaterialButton(
                minWidth: adaptWidgetWidth(50),
                padding: EdgeInsets.symmetric(horizontal: adaptWidgetWidth(10)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text('Всі',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: adaptWidgetHeight(18),
                        fontWeight: movie.selectedShowFormat == 'All'
                            ? FontWeight.w700
                            : FontWeight.w300)),
                onPressed: () {
                  movie.updateCurrentFormat('All');
                  movie.performSessionFiltration();
                },
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movie.allFormatTags.length,
                  itemBuilder: (BuildContext context, index) => Container(
                    margin: EdgeInsets.zero,
                    // width: adaptWidgetWidth(58),
                    child: MaterialButton(
                      minWidth: adaptWidgetWidth(50),
                      padding: EdgeInsets.symmetric(
                          horizontal: adaptWidgetWidth(10)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        movie.updateCurrentFormat(
                            movie.allFormatTags[index].tagName);
                        movie.performSessionFiltration();
                      },
                      child: Text(
                        movie.allFormatTags[index].tagName,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: adaptWidgetHeight(18),
                            fontWeight: movie.selectedShowFormat ==
                                    movie.allFormatTags[index].tagName
                                ? FontWeight.w700
                                : FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
