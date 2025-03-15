import '../exports.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.pop(context);
          },
      child: Container(
        width: 44.w, // Adjust size as needed
        height: 44.h,
        decoration: BoxDecoration(
          color: AppColors.lightWhite,
          shape: BoxShape.rectangle,
          borderRadius:
              BorderRadius.circular(15.r), // Circular with rounded corners
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 8.w),
            child: const Icon(
              Icons.arrow_back_ios, // Icon similar to the image
              color: Colors.grey, // Match the color of the arrow
              //     size: 18.sp, // Adjust size as needed
            ),
          ),
        ),
      ),
    );
  }
}

class CustomForwardButton extends StatelessWidget {
  const CustomForwardButton({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap ?? Navigator.pop(context);
      },
      child: Container(
        width: 44.w, // Adjust size as needed
        height: 44.h,
        decoration: BoxDecoration(
          color: AppColors.lightWhite,
          shape: BoxShape.rectangle,
          borderRadius:
              BorderRadius.circular(15.r), // Circular with rounded corners
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 8.w),
            child: const Icon(
              Icons.arrow_forward_ios, // Icon similar to the image
              color: Colors.grey, // Match the color of the arrow
              //     size: 18.sp, // Adjust size as needed
            ),
          ),
        ),
      ),
    );
  }
}
