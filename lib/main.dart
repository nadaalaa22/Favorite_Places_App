
import 'package:favorite_places_app/favorite_place/data/datasource/place_remote_datasource.dart';
import 'package:favorite_places_app/favorite_place/data/model/place.dart';
import 'package:favorite_places_app/stream.dart';
import 'package:favorite_places_app/user/data/datasorce/authentication_remote_ds/authentication.dart';
import 'package:favorite_places_app/user/presentation/bloc/authentication_bloc.dart';
import 'package:favorite_places_app/user/presentation/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_place/data/datasource/remote_db_helper.dart';
import 'favorite_place/presentation/bloc/place_bloc.dart';
import 'favorite_place/presentation/pages/add_new_place_page.dart';
import 'favorite_place/presentation/pages/favorite_places_page.dart';

@pragma('vm:entry_point')
Future<void> onBackgroundMessage (RemoteMessage message) async {
  print('Notification Received While App Is In The Background');
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.getToken().then((value) => print(value));
  FirebaseMessaging.instance.subscribeToTopic('topic');
  FirebaseMessaging.onMessage.listen(
      (event) => print('Notification Received While App Is In The Foreground'));
  FirebaseMessaging.onMessageOpenedApp
      .listen((event)=>print('Notification Tapped'));


  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (context) => AuthenticationBloc(AuthenticationImp())),
        BlocProvider<PlaceBloc>(create: (context) => PlaceBloc(FavoritePlaceImp(RemoteDBHelperImp()))),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AddNewPlace(),
    );
  }
}
