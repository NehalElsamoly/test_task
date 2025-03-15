import '../../../../core/exports.dart';
import '../../data/model/get_list_data_model.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key,required this.title,required this.desc});
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomContainerWithShadow(child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: Text(title.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: AppColors.primary),)),
                Icon(Icons.access_time_filled_rounded,color: AppColors.primary,)
              ],
            ),
            Text(desc,style: getMediumStyle(fontSize: 14.sp,color: AppColors.black), ),
          ],
        ),
      )),
    );
  }
}
