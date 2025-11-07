import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', '');

  void _changeLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MyHomePage(onLanguageChanged: _changeLanguage),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Function(String) onLanguageChanged;

  MyHomePage({required this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: onLanguageChanged,
            itemBuilder: (BuildContext context) {
              return <String>['en', 'es', 'fr', 'de', 'ur']
                  .map((String languageCode) {
                return PopupMenuItem<String>(
                  value: languageCode,
                  child: Text(_languageName(languageCode)),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localizations.message,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              localizations.messageDescription,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _languageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Spanish';
      case 'fr':
        return 'France';
      case 'de':
        return 'German';
      case 'ur':
        return 'Urdu';
      default:
        return 'Unknown';
    }
  }
}
