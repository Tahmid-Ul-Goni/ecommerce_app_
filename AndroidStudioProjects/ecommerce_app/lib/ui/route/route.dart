import 'package:ecommerce_app/Splash.dart';
import 'package:ecommerce_app/bussiness_logic/bindings/auth_binding.dart';
import 'package:ecommerce_app/bussiness_logic/bindings/cart_binding.dart';
import 'package:ecommerce_app/bussiness_logic/bindings/checkOut_binging.dart';
import 'package:ecommerce_app/onBoarding.dart';
import 'package:get/get.dart';
import '../../Home.dart';
import '../../bottom_nav.dart';
import '../../bussiness_logic/bindings/Fav_binding.dart';
import '../../bussiness_logic/bindings/SPlash_binding.dart';
import '../../check_outPage.dart';
import '../../success_page.dart';
import '../../terms.dart';
import '../views/Auth/forget_password.dart';
import '../views/Auth/log_in.dart';
import '../views/Auth/registration.dart';

const String splash = '/splash-screen';
const String home = '/home';
const String intro = '/intro';
const String login = '/login';
const String forgetPassword = '/ForgetPassword';
const String registration = '/registration';
const String terms = '/terms';
const String bottomNav = '/bottomNav';
const String detailsScreen = '/detailsScreen';
const String favourite = '/favouriteScreen';
const String checkoutPage = '/checkoutPage';
const String successPage = '/SuccessPage';

List<GetPage> getPages = [
  GetPage(name: splash, page: () => Splash(), binding: SplashBinding()),
  GetPage(name: home, page: () => Home(),),
  GetPage(name: intro, page: () => onBoarding()),

  GetPage(name: login, page: () => LogIn(), binding: AuthBinding()),
  GetPage(
    name: forgetPassword,
    page: () => ForgetPassword(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: registration,
    page: () => Registration(),
    binding: AuthBinding(),
  ),
  GetPage(name: terms, page: () => Terms()),
  GetPage(
    name: checkoutPage,
    page: () => CheckoutPage(),

  ),

  GetPage(name: bottomNav, page: () => BottomNav(),
    bindings: [FavouriteBinding(), CartBinding(), CheckoutBinding()],),
  GetPage(name: detailsScreen, page: () => DetailsScreen(data: Get.arguments)),
  GetPage(name: successPage, page: () => SuccessPage()),
];
