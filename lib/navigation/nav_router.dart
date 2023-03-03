import 'package:cinema_kiosk_app/ui/screens/support/support.dart';
import 'package:go_router/go_router.dart';
import '../ui/screens/authorization/authorization.dart';
import '../ui/screens/screens.dart';
import '../ui/screens/settings/setting.dart';

class NavRouter {
  // 1
  // final LoginState loginState;
  NavRouter();

  // 2
  late final router = GoRouter(
    // 3
    // refreshListenable: loginState,
    // 4
    debugLogDiagnostics: true,
    // 5
    // urlPathStrategy: UrlPathStrategy.path,

    // initialLocation: '/',

    // 6
    routes: [
      GoRoute(
        name: advertisingPoster,
        path: '/',
        builder: (context, state) => const AdvertisingPosters(),
        routes: [
          GoRoute(
            name: schedule,
            path: 'schedule',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: Schedule()),
            // const Schedule(),
            routes: [
              GoRoute(
                name: scheduleForTicketBooking,
                path: 'scheduleForTicketBooking/:sessionId',
                builder: (context, state) {
                  int sessionId = int.parse(state.params['sessionId']!);
                  return TicketBooking(
                    sessionId: sessionId,
                  );
                },
                routes: [
                  GoRoute(
                    name: scTicketBookingForCinemarket,
                    path: 'scTicketBookingForCinemarket',
                    pageBuilder: (context, state) {
                      int sessionId = int.parse(state.params['sessionId']!);
                      return NoTransitionPage(
                          child: Cinemarket(
                        sessionId: sessionId,
                      ));
                    },
                    routes: [
                      GoRoute(
                        name: scTiCinemarketForAuthorization,
                        path: 'scTiCinemarketForAuthorization',
                        pageBuilder: (context, state) {
                          int sessionId = int.parse(state.params['sessionId']!);
                          return NoTransitionPage(
                              child: Authorization(
                            sessionId: sessionId,
                          ));
                        },
                        routes: [
                          GoRoute(
                            name: scTiCiAuthorizationForTotal,
                            path: 'scTiCiAuthorizationForTotal',
                            builder: (context, state) {
                              int sessionId =
                                  int.parse(state.params['sessionId']!);
                              return Total(
                                sessionId: sessionId,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                    GoRoute(
                      name: scTicketBookingForAuthorization,
                      path: 'scTicketBookingForAuthorization',
                      pageBuilder: (context, state) {
                        int sessionId = int.parse(state.params['sessionId']!);
                        return NoTransitionPage(
                            child: Authorization(
                          sessionId: sessionId,
                        ));
                      },
                      routes: [
                        GoRoute(
                          name: scTiAuthorizationForTotal,
                          path: 'scTiAuthorizationForTotal',
                          builder: (context, state) {
                            int sessionId =
                            int.parse(state.params['sessionId']!);
                            return Total(
                              sessionId: sessionId,
                            );
                          },
                        ),
                      ],
                    ),
                  ],

              ),
            ],
          ),
          GoRoute(
            name: advertisingPosterForOnSale,
            path: 'advertisingPosterForOnSale/:movieOnSaleId',
            pageBuilder: (context, state) {
              int movieOnSaleId = int.parse(state.params['movieOnSaleId']!);
              return NoTransitionPage(
                child: OnSale(
                  movieOnSaleId: movieOnSaleId,
                ),
              );
            },
          ),
          GoRoute(
            name: onSale,
            path: 'on_sale',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: OnSale()),
                // const OnSale(),
            routes: [
              GoRoute(
                name: onSaleForMovieCard,
                path: 'movie_card/:movieId',
                builder: (context, state) {
                  int movieId = int.parse(state.params['movieId']!);
                  return MovieCard(
                    movieCardId: movieId,
                  );
                },
              ),
              GoRoute(
                name: onSaleForTicketBooking,
                path: 'onSaleForTicketBooking/:sessionId',
                builder: (context, state) {
                  int sessionId = int.parse(state.params['sessionId']!);
                  return TicketBooking(
                    sessionId: sessionId,
                  );
                },
                routes: [
                  GoRoute(
                    name: onTicketBookingForCinemarket,
                    path: 'onTicketBookingForCinemarket',
                    pageBuilder: (context, state) {
                      int sessionId = int.parse(state.params['sessionId']!);
                      return NoTransitionPage(
                          child: Cinemarket(
                        sessionId: sessionId,
                      ));
                    },
                    routes: [
                      GoRoute(
                        name: onTiCinemarketForAuthorization,
                        path: 'onSaleForAuthorization',
                        pageBuilder: (context, state) {
                          int sessionId = int.parse(state.params['sessionId']!);
                          return NoTransitionPage(
                              child: Authorization(
                            sessionId: sessionId,
                          ));
                        },
                        routes: [
                          GoRoute(
                            name: onTiCiAuthorizationForTotal,
                            path: 'onSaleForTotal',
                            pageBuilder: (context, state) {
                              int sessionId =
                                  int.parse(state.params['sessionId']!);
                              return NoTransitionPage(
                                  child: Total(
                                sessionId: sessionId,
                              ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    name: onTicketBookingForAuthorization,
                    path: 'onSaleForAuthorization',
                    pageBuilder: (context, state) {
                      int sessionId = int.parse(state.params['sessionId']!);
                      return NoTransitionPage(
                          child: Authorization(
                        sessionId: sessionId,
                      ));
                    },
                    routes: [
                      GoRoute(
                        name: onTiAuthorizationForTotal,
                        path: 'onSaleForTotal',
                        pageBuilder: (context, state) {
                          int sessionId =
                          int.parse(state.params['sessionId']!);
                          return NoTransitionPage(
                              child: Total(
                            sessionId: sessionId,
                          ));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            name: comingSoon,
            path: 'coming_soon',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ComingSoon()),
            routes: [
              GoRoute(
                name: comingSoonForMovieCard,
                path: 'movie_card_coming_soon/:movieId',
                builder: (context, state) {
                  int movieId = int.parse(state.params['movieId']!);
                  return MovieCard(
                    movieCardId: movieId,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            name: cinemarket,
            path: 'cinemarket/:sessionId',
            pageBuilder: (context, state) {
              int sessionId = int.parse(state.params['sessionId']!);
              return NoTransitionPage(
                  child: Cinemarket(
                sessionId: sessionId,
              ));
            },
            routes: [
              GoRoute(
                name: cinemarketForAuthorization,
                path: 'cinemarketForAuthorization',
                pageBuilder: (context, state) {
                  int sessionId = int.parse(state.params['sessionId']!);
                  return NoTransitionPage(
                      child: Authorization(
                    sessionId: sessionId,
                  ));
                },
                routes: [
                  GoRoute(
                    name: ciAuthorizationForTotal,
                    path: 'ciAuthorizationForTotal',
                    pageBuilder: (context, state) {
                      int sessionId = int.parse(state.params['sessionId']!);
                      return NoTransitionPage(
                          child: Total(
                        sessionId: sessionId,
                      ));
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            name: loyalty,
            path: 'loyalty',
            // builder: (context, state) => const Loyalty(),
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: Loyalty()),
          ),
          GoRoute(
            name: support,
            path: 'support',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: Support()),
            // builder: (context, state) => const Support(),
            routes: [
              GoRoute(
                name: supportForSettings,
                path: 'supportForSettings',
                builder: (context, state) {
                  return const Settings();
                },
              ),
            ],
          ),
        ],
      ),
    ],
    // TODO: Add Error Handler
    // TODO Add Redirect
  );
}

const String advertisingPoster = 'advertisingPoster';
const String advertisingPosterForOnSale = 'advertisingPosterForOnSale';

const String schedule = 'schedule';
const String scheduleForTicketBooking = 'scheduleForTicketBooking';

const String scTicketBookingForCinemarket = 'scTicketBookingForCinemarket';
const String scTiCinemarketForAuthorization = 'scTiCinemarketForAuthorization';
const String scTiCiAuthorizationForTotal = 'scTiCiAuthorizationForTotal';

const String scTicketBookingForAuthorization = 'scTicketBookingForAuthorization';
const String scTiAuthorizationForTotal = 'scTiAuthorizationForTotal';

const String onSale = 'onSale';
const String onSaleForMovieCard = 'onSaleForMovieCard';

const String onSaleForTicketBooking = 'onSaleForTicketBooking';

const String onTicketBookingForCinemarket = 'onTicketBookingForCinemarket';
const String onTiCinemarketForAuthorization = 'onTiCinemarketForAuthorization';
const String onTiCiAuthorizationForTotal = 'onTiCiAuthorizationForTotal';

const String onTicketBookingForAuthorization = 'onTicketBookingForAuthorization';
const String onTiAuthorizationForTotal = 'onTiAuthorizationForTotal';


const String cinemarket = 'cinemarket';
const String cinemarketForAuthorization = 'cinemarketForAuthorization';
const String ciAuthorizationForTotal = 'ciAuthorizationForTotal';

const String comingSoon = 'comingSoon';
const String comingSoonForMovieCard = 'movieCardComingSoon';

const String loyalty = 'loyalty';
const String support = 'support';
const String supportForSettings = 'supportForSettings';

const String payment = 'payment';
const String paymentResult = 'paymentResult';
