import 'package:firebase_core/firebase_core.dart';
import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizzler/dino/game/dino_run.dart';
import 'package:quizzler/dino/models/player_data.dart';
import 'package:quizzler/dino/models/settings.dart';
import 'package:quizzler/dino/widgets/game_over_menu.dart';
import 'package:quizzler/dino/widgets/hud.dart';
import 'package:quizzler/dino/widgets/main_menu.dart';
import 'package:quizzler/dino/widgets/pause_menu.dart';
import 'package:quizzler/dino/widgets/settings_menu.dart';
import 'package:quizzler/firebase_options.dart';
import 'package:quizzler/screens/chat_screen.dart';
import 'package:quizzler/screens/main_chat_screen.dart';
import 'package:quizzler/screens/registration_screen.dart';
import 'package:quizzler/screens/signin_screens.dart';
import 'package:quizzler/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initHive();
  runApp(MyApp());
}

Future<void> initHive() async {
  // For web hive does not need to be initialized.
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dino Run',
      theme: ThemeData(
        fontFamily: 'Audiowide',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Settings up some default theme for elevated buttons.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            fixedSize: const Size(200, 60),
          ),
        ),
      ),
      home: Scaffold(
        body: GameWidget<DinoRun>.controlled(
          // This will dislpay a loading bar until [DinoRun] completes
          // its onLoad method.
          loadingBuilder: (conetxt) => const Center(
            child: SizedBox(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ),
          // Register all the overlays that will be used by this game.
          overlayBuilderMap: {
            MainMenu.id: (_, game) => MainMenu(game),
            PauseMenu.id: (_, game) => PauseMenu(game),
            Hud.id: (_, game) => Hud(game),
            GameOverMenu.id: (_, game) => GameOverMenu(game),
            SettingsMenu.id: (_, game) => SettingsMenu(game),
          },
          // By default MainMenu overlay will be active.
          initialActiveOverlays: const [MainMenu.id],
          gameFactory: () => DinoRun(
            // Use a fixed resolution camera to avoid manually
            // scaling and handling different screen sizes.
            camera: CameraComponent.withFixedResolution(
              width: 360,
              height: 180,
            ),
          ),
        ),
      ),
      // initialRoute: _auth.currentUser != null ? MainChatScreen.screenRoute : WelcomeScreen.screenRoute,
      routes: {
        WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
        Registrationscreen.screenRoute: (context) => Registrationscreen(),
        chatScreen.screenRoute: (context) => chatScreen(),
        signinscreens.screenRoute: (context) => signinscreens(),
        MainChatScreen.screenRoute: (context) => MainChatScreen(),
      },
    );
  }
}
