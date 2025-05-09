import 'package:bossloot_mobile/providers/category_provider.dart';
import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/providers/favorite_provider.dart';
import 'package:bossloot_mobile/providers/language_provider.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/providers/size_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/loading_screen/loading_screen.dart';
import 'package:bossloot_mobile/services/category_service.dart';
import 'package:bossloot_mobile/services/coin_exchange_service.dart';
import 'package:bossloot_mobile/services/favorite_service.dart';
import 'package:bossloot_mobile/services/product_service.dart';
import 'package:bossloot_mobile/services/token_service.dart';
import 'package:bossloot_mobile/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {


  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
    void initState() {
      super.initState();
      _loadEnv();
    }

    Future<void> _loadEnv() async {
      await dotenv.load(fileName: ".env");
    }

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
          create: (_) => SizeProvider(),
        ),
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
          create: (_) => CoinExchangeProvider(CoinExchangeService()),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(favoriteService: FavoriteService(), tokenService: TokenService(),),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BossLoot',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: context.watch<LanguageProvider>().locale,
            supportedLocales: const [
              Locale('en'),
              Locale('es'),
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 110, 72, 121)),
              useMaterial3: true,
            ),
            home: SafeArea(child: const LoadingScreen()),
          );
        },
      ),
    );
  }
}
