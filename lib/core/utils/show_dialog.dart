import 'package:travel_club/core/exports.dart';

createProgressDialog(BuildContext context, String msg) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        content: Row(
          children: [
            CustomLoadingIndicator(),
            SizedBox(
              width: 16.0,
            ),
            Text(
              msg,
              style: TextStyle(color: AppColors.black, fontSize: 15.0),
            )
          ],
        ),
      );
    },
  );
}
