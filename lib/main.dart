import 'package:bossloot_mobile/providers/cart/cart_provider.dart';
import 'package:bossloot_mobile/providers/category_provider.dart';
import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/providers/contact_provider.dart';
import 'package:bossloot_mobile/providers/favorite_provider.dart';
import 'package:bossloot_mobile/providers/language_provider.dart';
import 'package:bossloot_mobile/providers/orders/order_provider.dart';
import 'package:bossloot_mobile/providers/paypal/paypal_provider.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/providers/size_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/providers/valoration_provider.dart';
import 'package:bossloot_mobile/screens/loading_screen/loading_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/cart_screen/cart_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/checkout_screen/checkout_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/main_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/orders_screen/order_confirmation_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/orders_screen/orders_screen.dart';
import 'package:bossloot_mobile/services/cart/cart_service.dart';
import 'package:bossloot_mobile/services/category_service.dart';
import 'package:bossloot_mobile/services/coin_exchange_service.dart';
import 'package:bossloot_mobile/services/contact_service.dart';
import 'package:bossloot_mobile/services/favorite_service.dart';
import 'package:bossloot_mobile/services/orders/order_service.dart';
import 'package:bossloot_mobile/services/paypal/paypal_service.dart';
import 'package:bossloot_mobile/services/product_service.dart';
import 'package:bossloot_mobile/services/token_service.dart';
import 'package:bossloot_mobile/services/user_service.dart';
import 'package:bossloot_mobile/services/valoration_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

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
          create: (_) => ValorationProvider(valorationService: ValorationService()),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactProvider(contactMessageService: ContactMessageService()),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(CartService(TokenService())),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(OrderService(TokenService())),
        ),
        ChangeNotifierProvider(
          create: (_) => PayPalProvider(PayPalService(TokenService()), OrderProvider(OrderService(TokenService()))),
        )
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
            routes: {
              '/home': (ctx) => MainScreen(withPageIndex: 2,),
              '/cart': (ctx) => CartScreen(),
              '/checkout': (ctx) => CheckoutScreen(),
              '/order-confirmation': (ctx) => OrderConfirmationScreen(),
              '/orders': (ctx) => OrdersScreen(),
              '/products': (ctx) => MainScreen(withPageIndex: 1,),
            },
            home: SafeArea(child: const LoadingScreen()),
          );
        },
      ),
    );
  }
}
