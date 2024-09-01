import 'package:flutter/material.dart';
import 'package:gastosapp/generated/l10n.dart';
import 'package:gastosapp/pages/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      // [
      //   // Locale("es", "ES"),
      // ],
    ),
  );
}