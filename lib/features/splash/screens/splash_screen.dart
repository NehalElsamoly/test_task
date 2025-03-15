// import 'dart:async';

// import 'package:app_links/app_links.dart';
// import 'package:travel_club/core/exports.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late Timer _timer;

//   navigateToHome() async {
//     _timer = Timer(
//       const Duration(seconds: 3),
//       () {
//         _getStoreUser();
//       },
//     );
//   }

//   Future<void> _getStoreUser() async {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.getBool('onBoarding') != null) {
//       // TODO
//       if (AppConst.isLogged) {
//         Navigator.pushReplacementNamed(context, Routes.mainRoute);
//       } else {
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           Routes.loginRoute,
//           (route) => false,
//         );
//       }
//     } else {
//       Navigator.pushReplacementNamed(
//         context,
//         Routes.onboardingPageScreenRoute,
//       );
//     }
//   }

//   late final AppLinks _appLinks;

//   @override
//   void initState() {
//     super.initState();
//      _initializeAppLinks();
//   }

//   Future<void> _initializeAppLinks() async {
//     _appLinks = AppLinks();

//     // Handle initial deep link
//     final initialLink = await _appLinks.getInitialLink();
//     if (initialLink != null) {
//       _handleDeepLink(initialLink);
//     } else {
//       navigateToHome();
//     }

//     // Listen for deep links
//     _appLinks.uriLinkStream.listen((Uri? uri) {
//       if (uri != null) {
//         _handleDeepLink(uri);
//       }
//     }, onError: (err) {
//       debugPrint('Error handling deep link: $err');
//     });
//   }

//   void _handleDeepLink(Uri initialDeepLink) {
//     print("the link is : ${initialDeepLink.toString()}");
//     if (initialDeepLink.toString().contains("transportation")) {
//       // Uri uri = Uri.parse(initialDeepLink.toString());
//       String id = initialDeepLink.queryParameters['id'] ?? "-1";
//       Navigator.pushReplacementNamed(
//         context, Routes.detailsbookingTransportation,
//         // arguments: id
//       );
//     } else {
//       Navigator.pushReplacementNamed(context, Routes.mainRoute);
//     }
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PulseRotateSplashScreen();
//   }
// }

// class PulseRotateSplashScreen extends StatefulWidget {
//   const PulseRotateSplashScreen({Key? key}) : super(key: key);

//   @override
//   State<PulseRotateSplashScreen> createState() =>
//       _PulseRotateSplashScreenState();
// }

// class _PulseRotateSplashScreenState extends State<PulseRotateSplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _pulseAnimation;
//   late Animation<double> _rotateAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,

//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);

//     _pulseAnimation = TweenSequence<double>([
//       TweenSequenceItem(
//         tween: Tween(begin: 1.0, end: 1.2)
//             .chain(CurveTween(curve: Curves.easeInOut)),
//         weight: 50,
//       ),
//       TweenSequenceItem(
//         tween: Tween(begin: 1.2, end: 1.0)
//             .chain(CurveTween(curve: Curves.easeInOut)),
//         weight: 50,
//       ),
//     ]).animate(_controller);

//     _rotateAnimation = Tween<double>(
//       begin: 0.5,
//       end: 0, // Half rotation
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       body: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Stack(
//             alignment: Alignment.center,
//             children: [
//               Center(
//                 child: Transform.scale(
//                   scale: _pulseAnimation.value,
//                   child: Transform.rotate(
//                     angle: _rotateAnimation.value * 2 * 3.14159,
//                     child: Image.asset(
//                       ImageAssets.splashLogo,
//                       height: getHeightSize(context) * 0.3,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_club/core/exports.dart';
import '../../../core/preferences/preferences.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AppLinks _appLinks;
  Future<void> navigateToHome() async {
    await AppConst.initPrefs();
    print("isLogged value: ${AppConst.isLogged}"); // تحقق من القيمة في الـ Debug Console

    if (AppConst.isLogged) {
      print("User is logged in, navigating to main screen.");
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    } else {
      print("User is NOT logged in, navigating to login screen.");
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.loginRoute,
            (route) => false,
      );
    }
  }

  Future<void> _initializeAppLinks() async {
    _appLinks = AppLinks();
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleDeepLink(initialLink);
    } else {
      navigateToHome();
    }
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    }, onError: (err) {
      debugPrint('Error handling deep link: $err');
    });
  }

  void _handleDeepLink(Uri initialDeepLink) {
    print("the link is : ${initialDeepLink.toString()}");
    if (initialDeepLink.toString().contains("transportation")) {
      String id = initialDeepLink.queryParameters['id'] ?? "-1";
      // Navigator.pushReplacementNamed(
      //   context,
      //   Routes.detailsbookingTransportation,
      // );
    } else if (initialDeepLink.toString().contains("lodge") &&
        initialDeepLink.queryParameters['id'] != null) {
      String? id = initialDeepLink.queryParameters['id'];
      // id == null
      //     ? Navigator.pushReplacementNamed(context, Routes.mainRoute)
      //     : Navigator.pushReplacementNamed(context, Routes.lodgeDetailsRoute,
      //         arguments: LodgeDetailsArguments(lodgeId: int.parse(id)));
    } else {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return PulseRotateSplashScreen(
      onAnimationComplete: () {
     //   context.read<ResidenceCubit>().getmarker();
        _initializeAppLinks();
      },
    );
  }
}
class PulseRotateSplashScreen extends StatefulWidget {
  final VoidCallback onAnimationComplete;
  const PulseRotateSplashScreen({
    super.key,
    required this.onAnimationComplete,
  });

  @override
  State<PulseRotateSplashScreen> createState() =>
      _PulseRotateSplashScreenState();
}

class _PulseRotateSplashScreenState extends State<PulseRotateSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;
  late ImageProvider _imageProvider;
  bool _imageLoaded = false;

  @override
  void initState() {
    super.initState();

    _preloadImage();
  }

  Future<void> _preloadImage() async {
    _imageProvider = const AssetImage(ImageAssets.splashLogo);
    final ImageStream stream =
        _imageProvider.resolve(const ImageConfiguration());

    stream.addListener(ImageStreamListener((info, _) {
      setState(() {
        _imageLoaded = true;
        _initializeAnimation();
      });
    }));
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _rotateAnimation = Tween<double>(
      begin: 0.5,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: !_imageLoaded
          ? const SizedBox(
              height: 1,
            )
          : AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Transform.rotate(
                          angle: _rotateAnimation.value * 2 * 3.14159,
                          child: Image(
                            image: _imageProvider,
                            height: getHeightSize(context) * 0.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
