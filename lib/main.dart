import 'package:flutter/material.dart';
import 'package:overtime_connect_app/features/auth/splash/splash_view.dart';
import 'package:overtime_connect_app/provider_setup.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Overtime Connect App',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('id'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashView(),
      ),
    );
  }
}
