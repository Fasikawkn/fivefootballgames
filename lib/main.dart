import 'package:fivefootballgames/src/controllers/is_favorite_controller.dart';
import 'package:fivefootballgames/src/controllers/live_game_controller.dart';
import 'package:fivefootballgames/src/db/db_helper.dart';
import 'package:fivefootballgames/src/models/services/data/data_provider.dart';
import 'package:fivefootballgames/src/models/services/repository/repository.dart';
import 'package:fivefootballgames/src/views/screens/home_page.dart';
import 'package:fivefootballgames/src/views/screens/splash_screen.dart';
import 'package:fivefootballgames/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(const FiveFootBallGamesApp());
}

class FiveFootBallGamesApp extends StatelessWidget {
  const FiveFootBallGamesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LiveGameModel(
            liveGameRepository: LiveGameRepository(
              liveGameDataProvider: LiveGameDataProvider(
                httpClient: http.Client(),
              )
            )
            )..getFiveLiveGames()
          ),

           ChangeNotifierProvider<DBHelper>(
          create: (context) => DBHelper(),
        ),
        ChangeNotifierProxyProvider<DBHelper, FavoriteContorller>(
          create: (context) => FavoriteContorller( null, []),
          update: (context, db, previous) => FavoriteContorller(
             db,
             previous!.items,
          ),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: createMaterialColor(kPrimaryColor),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: kPrimaryColor,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
