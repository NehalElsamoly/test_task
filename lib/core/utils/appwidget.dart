
import 'package:travel_club/core/exports.dart';

class AppWidget {
  static createProgressDialog(BuildContext context, String? msg) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const CustomLoadingIndicator();
          //  AlertDialog(
          //   backgroundColor: AppColors.white,
          //   content: Row(
          //     children: [
          //       CustomLoadingIndicator(),
          //       const SizedBox(
          //         width: 16.0,
          //       ),
          //       Text(
          //         msg,
          //         style: TextStyle(color: AppColors.black, fontSize: 15.0),
          //       )
          //     ],
          //   ),
          // );
        });
  }
}
