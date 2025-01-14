import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nice_village/Localization/app_localizations.dart';
import 'package:nice_village/config/themes.dart';
import 'package:nice_village/providers/localization.dart';
import 'package:nice_village/screens/guest/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("=======================Firebase Connected Successfully!");
  } catch (e) {
    print("=======================Firebase Connection Failed: $e");
  }
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider()),
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.theme,
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
            Locale('fa'), // Kurdish (Central)
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Provider.of<LocaleProvider>(context).locale,
          home: const WelcomeScreen(),
        );
      },
    );
  }
}

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          PopupMenuButton<Locale>(
            onSelected: (Locale locale) {
              Provider.of<LocaleProvider>(context, listen: false)
                  .setLocale(locale);
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: Locale('en'),
                child: Text('English'),
              ),
              const PopupMenuItem(
                value: Locale('fa'),
                child: Text('کوردی'),
              ),
              const PopupMenuItem(
                value: Locale('ar'),
                child: Text('العربية'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Text(
            AppLocalizations.of(context)?.translate('welcome') ?? 'Welcome11'),
      ),
    );
  }
}
