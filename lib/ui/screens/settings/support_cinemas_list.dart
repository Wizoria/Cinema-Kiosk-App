import 'package:cinema_kiosk_app/ui/screens/settings/support_cinemas_list_elements.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/cinema.dart';
import '../../../repository/cinemas_repository.dart';
import '../../../repository/storage/cinema_preference.dart';
import '../../../service/app_manager.dart';
import 'cinema_chain_settings.dart';

class SupportCinemasList extends StatefulWidget {
  const SupportCinemasList({Key? key}) : super(key: key);

  @override
  State<SupportCinemasList> createState() => _SupportCinemasListState();
}

class _SupportCinemasListState extends State<SupportCinemasList> {
  // late Future<List<Cinema>> _futureCinemasList;

  @override
  void initState() {
    super.initState();

    // _futureCinemasList = CinemasRepository().getCinemasByChainId(AppManager().cinemaSettings.cinemaChainId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CinemaChainSettings>(builder: (context, cinemaChain, child) {
      return Material(
        // color: Colors.black,
        child: FutureBuilder<List<Cinema>>(
            // future: _futureCinemasList,
            future: CinemasRepository().getCinemasByChainId(AppManager().cinemaSettings.cinemaChainId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<Cinema> cinemas = snapshot.data as List<Cinema>;

                  bool isCinemaInCinemaChain = false;
                  for (Cinema cinema in cinemas) {
                    if (AppManager().cinemaSettings.cinemaId == cinema.id) {
                      isCinemaInCinemaChain = true;
                    }
                  }
                  if (!isCinemaInCinemaChain) {
                    for (Cinema cinema in cinemas) {
                      // AppManager().cinemaSettings.cinemaId = cinema.id;
                      // AppManager().cinemaSettings.cinemaName = cinema.title;
                      // CinemaPreference cinemaPreference = CinemaPreference();
                      // cinemaPreference.setCinemaId(AppManager().cinemaSettings.cinemaId);
                      // cinemaPreference.setCinemaName(AppManager().cinemaSettings.cinemaName);
                      CinemaPreference cinemaPreference = CinemaPreference();
                      cinemaPreference.setCinemaId(AppManager().cinemaSettings.cinemaId = cinema.id);
                      cinemaPreference.setCinemaName(AppManager().cinemaSettings.cinemaName = cinema.title);
                      break;
                    }
                  }

                  return SupportCinemasListElements(
                    cinemas: cinemas,
                  );
                  // return ListView.builder(
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   itemCount: cinemas.length,
                  //   itemBuilder: (context, index) {
                  //     // return Text(cinemas[index].title);
                  //     return RadioListTile(
                  //       title: Text(cinemas[index].title),
                  //       value: cinemas[index].id,
                  //       groupValue: AppManager().cinemaSettings.cinemaId,
                  //       onChanged: (void value) {
                  //         AppManager().cinemaSettings.cinemaId = cinemas[index].id;
                  //         CinemaPreference cinemaPreference = CinemaPreference();
                  //         cinemaPreference.setCinemaId(AppManager().cinemaSettings.cinemaId);
                  //         cinemaPreference.setCinemaName(AppManager().cinemaSettings.cinemaName);
                  //         setState(() {});
                  //         log(AppManager().cinemaSettings.cinemaId.toString());
                  //       },
                  //     );
                  //   },
                  // );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }
              return Container(padding: const EdgeInsets.only(top: 20, bottom: 20), child: const Center(child: Text("Fetching...")));
            }),
      );
    });
  }
}
