import 'package:flutter/widgets.dart';
import 'package:sneaker_store/screens/dashboard/dashboard.dart';
import 'package:sneaker_store/screens/drawer_screen/drawer_screen.dart';
import 'package:sneaker_store/screens/favourite/favourite.dart';
import 'package:sneaker_store/screens/home/home.dart';
import 'package:sneaker_store/screens/my_cart/my_cart.dart';
import 'package:sneaker_store/screens/orders/orders.dart';
import 'package:sneaker_store/screens/profile/profile.dart';
import 'package:sneaker_store/screens/register_account/register_account.dart';
import 'package:sneaker_store/screens/sign_in/sign_in.dart';
import 'package:sneaker_store/screens/splash/splash_screen.dart';
import 'package:sneaker_store/screens/walk_through/walk_through.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  WalkThrough.routeName: (context) => const WalkThrough(),
  SignIn.routeName: (context) => const SignIn(),
  Register.routeName: (context) => const Register(),
  Home.routeName: (context) => const Home(),
  Dashboard.routeName: (context) => const Dashboard(),
  Favourite.routeName: (context) => const Favourite(),
  MyCart.routeName: (context) => const MyCart(),
  Orders.routeName: (context) => const Orders(),
  Profile.routeName: (context) => const Profile(),
  DrawerScreen.routeName: (context) => const DrawerScreen(),
};
