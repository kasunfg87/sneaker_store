import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:sneaker_store/firebase_options.dart';
import 'package:sneaker_store/provider/cart_provider.dart';
import 'package:sneaker_store/provider/favourite_provider.dart';
import 'package:sneaker_store/provider/order_provider.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/provider/user_provider.dart';
import 'package:sneaker_store/routes.dart';
import 'package:sneaker_store/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => UserProvider())),
        ChangeNotifierProvider(create: ((context) => ProductProvider())),
        ChangeNotifierProvider(create: ((context) => FavouriteProvider())),
        ChangeNotifierProvider(create: ((context) => CartProvider())),
        ChangeNotifierProvider(create: ((context) => OrderPrvider())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Nike Sneaker Store App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: routes,
      initialRoute: SplashScreen.routeName,
    );
  }
}
