
import '../../../../core/exports.dart';

class CustomBackContainer extends StatelessWidget {
  CustomBackContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 83.w,
      // height:36.h ,
      decoration: BoxDecoration(
          color: AppColors.lightWhite,
          borderRadius: BorderRadius.circular(18.r)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
           
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //grey
              Icon(
                Icons.arrow_back_ios,
                color: AppColors.grey,
              ),
              Text(
                AppTranslations.back,
                style: getSemiBoldStyle(color: AppColors.grey, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
