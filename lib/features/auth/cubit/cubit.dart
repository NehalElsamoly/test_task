import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_club/core/preferences/preferences.dart';
import 'package:travel_club/core/utils/appwidget.dart';
import 'package:travel_club/features/main_screen/cubit/cubit.dart';

import '../../../core/exports.dart';
import '../../../core/utils/restart_app_class.dart';
import '../data/models/login_model.dart';
import '../data/login_repo_impl.dart';
import 'state.dart';

//ya29.a0ARW5m75XCuAi6zuyPKuHI-Y0anNF2A8jgdJjEw21BRvMneo1dz6YmaGSj-2mx2p264ym5XLZ9HjevPHjvbY7qSeJ8gC4Ckg7SBcCmCF10B69q8wuMsA9nw5woRRfydexChhj-k8slstayN-1wYjtQc5UIHFH7a-cRUauVxJ0UwaCgYKAW4SARMSFQHGX2MiiiHA8cakZ1f7WtPCKv-CBg0177
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginStateInitial());
  LoginRepoImpl api;
  //login
  late TextEditingController userNameController = TextEditingController();
  late TextEditingController phoneControllerForgetPass =
      TextEditingController();
  late TextEditingController passwordControllerLogin = TextEditingController();
  //forget pass
  //sign up
  void changeLanguage(BuildContext context, String newLanguage) {
    // selectedLanguage = newLanguage; // Update the selected language

    // Map of language display names to their codes
    final Map<String, String> languageCodes = {
      'Arabic': 'ar',
      'English': 'en',
      'German': 'de',
      'Italian': 'it',
      'Korean': 'ko',
      'Russian': 'ru',
      'Spanish': 'es'
    };

    // Get the language code from the map
    final String langCode = languageCodes[newLanguage] ?? 'en';

    // Set the locale
    context.setLocale(Locale(langCode, ''));

    // Save the language preference
    Preferences.instance.savedLang(langCode);

    emit(LanguageChanged()); // Emit a new state to notify the UI
    Preferences.instance.getSavedLang();
    HotRestartController.performHotRestart(context);
  }

  TextEditingController codeController = TextEditingController();
  changeCode(String value) {
    codeController.text = value;
    emit(ChangeCodeState());
  }

  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailControllerSignUp = TextEditingController();
  late TextEditingController userNameSignUp = TextEditingController();
  late TextEditingController phoneControllerSignUp = TextEditingController();
  late TextEditingController passwordControllerSignUp = TextEditingController();
  late TextEditingController confirmPasswordControllerSignUp =
      TextEditingController();
  //otp screen

  final TextEditingController pinController =
      TextEditingController(); // Controller for PIN input

  // Sign in with google
  String userGmail = '';
  String userPhoto = '';
  String userName = '';
  String? accessToken = '';
  // Future<UserCredential?> signInWithGoogle(
  //   BuildContext context,
  // ) async {
  //
  //   print("Starting Google Sign-In process...");
  //
  //   try {
  //     final GoogleSignIn _googleSignIn = GoogleSignIn(
  //       scopes: [
  //         'email',
  //         'https://www.googleapis.com/auth/userinfo.profile',
  //         'openid',
  //       ],
  //     );
  //
  //     // Trigger Google Sign-In
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     print("Google Sign-In successful: ${googleUser != null}");

      // Handle user cancellation
      // if (googleUser == null) {
      //   print("Google Sign-In was cancelled by the user.");
      //   emit(FailureSignInWithGoogleState(error: 'Sign-in cancelled by user'));
      //   return null;
      // }
      //
      // // Retrieve authentication tokens
      // final GoogleSignInAuthentication googleAuth =
      //     await googleUser.authentication;
      // print("Access Token retrieved: ${googleAuth.accessToken != null}");
      // print("Access Token retrieved: ${googleAuth.accessToken.toString()}");
      // print("ID Token retrieved: ${googleAuth.idToken != null}");
      // print("ID Token retrieved: ${googleAuth.idToken.toString()}");
      // if (googleAuth.accessToken != null) {
      //   loginWithGoogle(context,
      //       accessToken: googleAuth.accessToken.toString());
      // }
      // // Validate tokens
      // if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      //   print("Missing required authentication tokens.");
      //   emit(FailureSignInWithGoogleState(
      //       error: 'Missing authentication tokens'));
      //   throw Exception('Missing Google authentication tokens.');
      // }
      //
      // // Create Firebase credential
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );
      //
      // // Store the access token locally if needed
      // accessToken = googleAuth.accessToken;
      //
      // // Emit success state for Google Sign-In
      // emit(SuccessSignInWithGoogleState());
      // print("Firebase credential created successfully. Signing in...");

  //     try {
  //       // Sign in to Firebase with additional error handling
  //       final UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //       print(
  //           "Firebase Sign-In successful. User ID: ${userCredential.user?.uid}");
  //       return userCredential;
  //     } on FirebaseAuthException catch (e) {
  //       print("Firebase Auth Exception: ${e.code} - ${e.message}");
  //       emit(FailureSignInWithGoogleState(
  //         error: _getFirebaseErrorMessage(e.code),
  //       ));
  //       return null;
  //     }
  //   } on PlatformException catch (e) {
  //     print(
  //         "Platform Exception during Google Sign-In: ${e.code}, ${e.message}");
  //     emit(FailureSignInWithGoogleState(error: e.message));
  //   } catch (e) {
  //     print("Unexpected error during Google Sign-In: $e");
  //     emit(FailureSignInWithGoogleState(error: e.toString()));
  //   }
  //
  //   return null;
  // }

// Helper function to provide user-friendly error messages
//   String _getFirebaseErrorMessage(String code) {
//     switch (code) {
//       case 'account-exists-with-different-credential':
//         return 'An account already exists with the same email address but different sign-in credentials.';
//       case 'invalid-credential':
//         return 'The credential data is malformed or has expired.';
//       case 'operation-not-allowed':
//         return 'Google sign-in is not enabled for this project.';
//       case 'user-disabled':
//         return 'This user account has been disabled.';
//       case 'user-not-found':
//         return 'No user found for this credential.';
//       default:
//         return 'An unknown error occurred during sign-in.';
//     }
//   }
//
//   Future<GoogleSignInAccount?> signOutFromGmail() async {
//     emit(LoadingSignOutGoogleState());
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
//
//     emit(SuccessSignOutGoogleState());
//
//     return googleUser;
//   }
//
  String? selectedUserType;

  String countryCode = '+20';
  void updateUserType(String? newValue) {
    selectedUserType= newValue;
    if (newValue != null) {
      emit(NewValue());
    }
  }
//   // login
//   LoginModel loginModel = LoginModel();
  // login(BuildContext context) async {
  //   emit(LoadingLoginState());
  //   AppWidget.createProgressDialog(context, AppTranslations.loading);
  //   final response = await api.login(
  //     phone: countryCode + phoneController.text,
  //     password: passwordControllerLogin.text,
  //   );
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar(AppTranslations.error);
  //     emit(FailureLoginState());
  //   }, (r) {
  //     debugPrint("code: ${r.status.toString()}");
  //     if (r.status != 200 && r.status != 201) {
  //       Navigator.pop(context);
  //       errorGetBar(r.msg!);
  //     } else {
  //       loginModel = r;
  //       phoneController.clear();
  //       passwordControllerLogin.clear();
  //       context.read<MainCubit>().changePage(0);
  //       emit(SuccessLoginState());
  //       Navigator.pop(context);
  //       successGetBar(r.msg);
  //       prefs.setBool("ISLOGGED", true);
  //       Preferences.instance.setUser(r);
  //       Navigator.pushNamedAndRemoveUntil(context, Routes.mainRoute, (route) => false);
  //     }
  //   });
  // }

  // login google
  // loginWithGoogle(BuildContext context, {required String accessToken}) async {
  //   emit(LoadingLoginState());
  //   AppWidget.createProgressDialog(context, AppTranslations.loading);
  //   final response = await api.loginWithGoogle(accessToken: accessToken);
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar(AppTranslations.error);
  //     emit(FailureLoginState());
  //   }, (r) {
  //     debugPrint("code: ${r.status.toString()}");
  //     if (r.status != 200 && r.status != 201) {
  //       Navigator.pop(context);
  //       errorGetBar(r.msg!);
  //     } else {
  //       loginModel = r;
  //       phoneController.clear();
  //       passwordControllerLogin.clear();
  //       context.read<MainCubit>().changePage(0);
  //
  //       emit(SuccessLoginState());
  //       Navigator.pop(context);
  //       successGetBar(r.msg);
  //       prefs.setBool("ISLOGGED", true);
  //       Preferences.instance.setUser(r);
  //       if (r.data?.isRegister != null) {
  //         r.data?.isRegister??false ?
  //           Navigator.pushNamedAndRemoveUntil(
  //           context, Routes.apply, (route) => false)
  //         :
  //           Navigator.pushNamedAndRemoveUntil(
  //           context, Routes.mainRoute, (route) => false);
  //       } else {
  //           Navigator.pushNamedAndRemoveUntil(
  //           context, Routes.mainRoute, (route) => false);
  //       }
  //     }
  //   });
  // }

  // register
  // register(BuildContext context, {bool isResend = false}) async {
  //   emit(LoadingLoginState());
  //   AppWidget.createProgressDialog(context, AppTranslations.loading);
  //   final response = await api.register(
  //       isCheckOtp: false,
  //       phone: countryCode + phoneController.text,
  //       password: passwordControllerSignUp.text,
  //       name: nameController.text,
  //       passwordConfirmation: confirmPasswordControllerSignUp.text);
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar(AppTranslations.error);
  //     emit(FailureLoginState());
  //   }, (r) {
  //     Navigator.pop(context);
  //     print("code: ${r.status.toString()}");
  //     if (r.status != 200 && r.status != 201) {
  //       errorGetBar(r.msg!);
  //     } else {
  //       emit(OTPSentState());
  //       successGetBar(r.msg);
  //       if (!isResend) {
  //         Navigator.pushNamed(context, Routes.otpScreen, arguments: false);
  //       }
  //     }
  //   });
  // }

  // checkOtp(BuildContext context) async {
  //   emit(LoadingLoginState());
  //   AppWidget.createProgressDialog(context, AppTranslations.loading);
  //   final response = await api.register(
  //       isCheckOtp: true,
  //       otp: pinController.text,
  //       phone: countryCode + phoneController.text,
  //       password: passwordControllerSignUp.text,
  //       name: nameController.text,
  //       passwordConfirmation: confirmPasswordControllerSignUp.text);
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar(AppTranslations.error);
  //     emit(FailureLoginState());
  //   }, (r) {
  //     Navigator.pop(context);
  //     print("code: ${r.status.toString()}");
  //     if (r.status != 200 && r.status != 201) {
  //       errorGetBar(r.msg!);
  //     } else {
  //       emit(SuccessLoginState());
  //       phoneController.clear();
  //       passwordControllerSignUp.clear();
  //       confirmPasswordControllerSignUp.clear();
  //       pinController.clear();
  //       nameController.clear();
  //       successGetBar(r.msg);
  //       prefs.setBool("ISLOGGED", true);
  //       Preferences.instance.setUser(r);
  //       context.read<MainCubit>().changePage(0);
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, Routes.apply, (route) => false);
  //     }
  //   });
  // }

  // forgetPassword(BuildContext context, {bool isResend = false}) async {
  //   emit(LoadingLoginState());
  //   AppWidget.createProgressDialog(context, AppTranslations.loading);
  //   final response = await api.forgetPassword(
  //     phone: countryCode + phoneControllerForgetPass.text,
  //   );
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar(AppTranslations.error);
  //     emit(FailureLoginState());
  //   }, (r) {
  //     Navigator.pop(context);
  //     print("code: ${r.status.toString()}");
  //     if (r.status != 200 && r.status != 201) {
  //       errorGetBar(r.msg!);
  //     } else {
  //       emit(OTPSentState());
  //       successGetBar(r.msg);
  //       if (!isResend) {
  //         Navigator.pushNamed(context, Routes.otpScreen, arguments: true);
  //       }
  //     }
  //   });
  // }

  // validateOtp(BuildContext context) async {
  //   emit(LoadingLoginState());
  //   AppWidget.createProgressDialog(context, AppTranslations.loading);
  //   final response = await api.validateOtp(
  //       phone: countryCode + phoneControllerForgetPass.text,
  //       otp: pinController.text);
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar(AppTranslations.error);
  //     emit(FailureLoginState());
  //   }, (r) {
  //     Navigator.pop(context);
  //     print("code: ${r.status.toString()}");
  //     if (r.status != 200 && r.status != 201) {
  //       errorGetBar(r.msg!);
  //     } else {
  //       emit(SuccessLoginState());
  //
  //       successGetBar(r.msg);
  //
  //       Navigator.pushNamed(
  //         context,
  //         Routes.newPass,
  //       );
  //     }
  //   });
  // }

  // resetPassword(BuildContext context) async {
  //   emit(LoadingLoginState());
  //   AppWidget.createProgressDialog(context, AppTranslations.loading);
  //   final response = await api.resetPassword(
  //       phone: countryCode + phoneControllerForgetPass.text,
  //       password: passwordControllerSignUp.text,
  //       passwordConfirmation: confirmPasswordControllerSignUp.text);
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar(AppTranslations.error);
  //     emit(FailureLoginState());
  //   }, (r) {
  //     Navigator.pop(context);
  //     print("code: ${r.status.toString()}");
  //     if (r.status != 200 && r.status != 201) {
  //       errorGetBar(r.msg!);
  //     } else {
  //       emit(SuccessLoginState());
  //       phoneController.clear();
  //       passwordControllerSignUp.clear();
  //       confirmPasswordControllerSignUp.clear();
  //       pinController.clear();
  //       nameController.clear();
  //       successGetBar(r.msg);
  //       prefs.setBool("ISLOGGED", true);
  //       Preferences.instance.setUser(r);
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, Routes.mainRoute, (route) => false);
  //     }
  //   });
  // }

  // acceptReferral(BuildContext context, {required String code}) async {
  //   emit(LoadingLoginState());
  //   AppWidget.createProgressDialog(context, AppTranslations.loading);
  //   final response = await api.acceptReferral(
  //     code: code,
  //   );
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar(AppTranslations.error);
  //     emit(FailureLoginState());
  //   }, (r) {
  //     Navigator.pop(context);
  //     print("code: ${r.status.toString()}");
  //     if (r.status != 200 && r.status != 201) {
  //       errorGetBar(r.msg!);
  //     } else {
  //       emit(SuccessLoginState());
  //
  //       successGetBar(r.msg);
  //
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, Routes.mainRoute, (route) => false);
  //     }
  //   });
  // }

  // logout(BuildContext context) async {
  //   emit(LoadingLoginState());
  //   AppWidget.createProgressDialog(context, AppTranslations.loading);
  //   final response = await api.logout();
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar(AppTranslations.error);
  //     emit(FailureLoginState());
  //   }, (r) {
  //     print("code: ${r.status.toString()}");
  //     if (r.status != 200 && r.status != 201) {
  //       Navigator.pop(context);
  //       prefs.setBool("ISLOGGED", false);
  //
  //       Preferences.instance.clearUser();
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, Routes.loginRoute, (route) => false);
  //     } else {
  //       Navigator.pop(context);
  //       successGetBar(r.msg);
  //       prefs.setBool("ISLOGGED", false);
  //
  //       Preferences.instance.clearUser();
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, Routes.loginRoute, (route) => false);
  //     }
  //     emit(SuccessLoginState());
  //   });
  // }
}
