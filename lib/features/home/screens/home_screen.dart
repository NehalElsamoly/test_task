// ignore_for_file: deprecated_member_use

import 'package:travel_club/core/exports.dart';

import 'home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeightSize(context),
      width: getWidthSize(context),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              child: Image.asset(
                ImageAssets.mask,
                fit: BoxFit.cover,
                height: getHeightSize(context) * 0.3,
                width: getWidthSize(context),
              )
          ),
          SizedBox(
              height: getHeightSize(context),
              width: getWidthSize(context),
              child: const HomeBody()
          )
        ],
      ),
    );
  }
}
