import 'package:flutter/material.dart';
import 'package:travel_club/features/home/screens/new_offers_screen.dart';
import 'package:travel_club/features/main_screen/screens/main_screen.dart';
import 'package:travel_club/features/my_account/screens/about_us.dart';


import 'package:travel_club/features/splash/screens/splash_screen.dart';
import 'package:travel_club/features/transportation/data/models/get_available_busis_model.dart';
import 'package:travel_club/features/transportation/data/models/get_companies_model.dart';

import '../../core/utils/app_strings.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/auth/view/screens/login_screen.dart';

import '../../features/auth/view/screens/sign_up_screen.dart';

import '../../features/my_account/screens/account_screen.dart';
import '../../features/my_account/screens/change_lang.dart';



class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String mainRoute = '/main';
  static const String newPass = '/newPass';
  static const String signUp = '/signUp';
  static const String forgetPass = '/forgetPass';
  static const String otpScreen = '/otpScreen';
  static const String apply = '/apply';
  static const String doneBooking = '/donePayment';
  static const String payment = '/payment';
  static const String contact = '/contact';
  static const String bestChoosenScreen = '/bestChoosenScreen';
  static const String aboutUs = '/aboutUs';
  static const String changeLanguage = '/changeLanguage';
  static const String profileInfo = '/profileInfo';
  static const String privacyRoute = '/privacyRoute';
  static const String hotelsScreen = '/hotelsScreen';
  static const String notificationScreen = '/notification';
  static const String detailsReservationResidence = '/detailsBooking';
  static const String compainiesEntertainment = '/compainiesEntertainment';
  static const String entertainmentScreen = '/entertainmentScreen';
  static const String bookingResidenceRoute = '/bookingResidenceRoute';
  static const String residenceRoute = '/residenceRoute';
  static const String foodScreen = '/foodScreen';
  static const String detailsBookingFood = '/detailsBookingFood';
  static const String detailsEntertainment = '/detailsEntertainment';
  static const String lodgeDetailsRoute = '/lodgeDetails';
  static const String onboardingPageScreenRoute = '/onboardingPageScreenRoute';
  static const String otherServicesRoute = '/otherServicesRoute';
  static const String transportationRoute = '/transportationRoute';
  static const String subServicesRoute = '/subServicesRoute';
  static const String detailsOtherServices = '/detailsOtherServices';
  static const String secondBookingResidence = '/secondBookingResidence';
  static const String detailsFoodRoute = '/detailsFoodRoute';
  static const String bookTable = '/bookTable';
  static const String bookTableEntermaint = '/bookTableEntermaint';
  static const String transportationMenuRoute = '/transportationMenuRoute';
  static const String transportationBookingDetailsRoute =
      '/transportationBookingDetailsRoute';
  static const String transportationSearchResultRoute =
      '/transportationSearchResultRoute';
  static const String tripDetailsfirstRoute = '/tripDetailsfirstRoute';
  static const String tripDetailsSecondRoute = '/tripDetailsSecondRoute';
  static const String offers = '/offers';
  static const String bags = '/bags';
  static const String searchScreen = '/searchScreen';
  static const String detailsBookingEntertainment =
      '/detailsBookingEntertainment';
  static const String detailsbookingTransportation =
      '/detailsbookingTransportation';
  static const String pointsRoute = '/pointsRoute';
  static const String secondBookingFood = '/secondBookingFood';
  static const String promoCodeRoute = '/promocodeRoute';
  static const String updatePassword = '/updatePassword';
  static const String accountScreen = '/accountScreen';
  static const String secondBookTableEntertainment =
      '/secondBookTableEntertainment';
}

class AppRoutes {
  static String route = '';
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
     case Routes.accountScreen:
        return PageTransition(
          child: const AccountScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200),
        );

      // case Routes.detailsBookingEntertainment:
      //   return PageTransition(
      //     child: const DetailsBookingEntertainment(),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     duration: const Duration(milliseconds: 200),
      //   );





      case Routes.aboutUs:
        return PageTransition(
          child: const AboutUs(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200),
        );


      case Routes.changeLanguage:
        return PageTransition(
          child: const ChangeLang(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200),
        );







      case Routes.signUp:
        return PageTransition(
          child: const SignUpScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200),
        );

      case Routes.loginRoute:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200),
        );

      case Routes.mainRoute:
        // final int index =
        // settings.arguments as int; // Expect an int
        return PageTransition(
          child: const MainScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200),
        );




      case Routes.offers:
        return PageTransition(
          child: const NewOffersScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200),
        );



      // case Routes.resultOfLessonExam:
      //   ResponseOfApplyLessonExmamData model =
      //       settings.arguments as ResponseOfApplyLessonExmamData;
      //   return PageTransition(
      //     child: ResultExamLessonScreen(model: model),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     duration: const Duration(milliseconds: 800),
      //   );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
  // case Routes.detailsRoute:
      //   final service = settings.arguments as ServicesModel;
      //   return MaterialPageRoute(
      //     // Extract the service model argument from the settings arguments map
      //
      //     builder: (context) => Details(service: service),
      //   );
      //