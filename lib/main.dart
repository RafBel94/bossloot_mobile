import 'package:bossloot_mobile/providers/category_provider.dart';
import 'package:bossloot_mobile/providers/favorite_provider.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/loading_screen/loading_screen.dart';
import 'package:bossloot_mobile/services/category_service.dart';
import 'package:bossloot_mobile/services/favorite_service.dart';
import 'package:bossloot_mobile/services/product_service.dart';
import 'package:bossloot_mobile/services/token_service.dart';
import 'package:bossloot_mobile/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {


  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(TokenService(), UserService()),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(CategoryService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(ProductService()),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(favoriteService: FavoriteService(), tokenService: TokenService(),),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BossLoot',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 110, 72, 121)),
          useMaterial3: true,
        ),
        home: SafeArea(child: const LoadingScreen()),
      ),
    );
  }

  void _changeLanguage(Locale locale){
    setState(() {
      _locale = locale;
    });
  }
}
