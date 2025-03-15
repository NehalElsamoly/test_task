import '../../../../core/exports.dart';

class CustomTitle extends StatelessWidget {
   CustomTitle({super.key,required this.title,this.discreption});
String title;
String ?discreption;
  @override
  Widget build(BuildContext context) {
    return Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,style: getSemiBoldStyle(color: AppColors.blue,fontSize: 20.sp)),
        if(discreption!=null)...[
          SizedBox(height: 10.h,),
          Text(discreption!,style: getMediumStyle(color: AppColors.grey,fontSize: 14.sp),)
        ]
      ],
    );
  }
}
