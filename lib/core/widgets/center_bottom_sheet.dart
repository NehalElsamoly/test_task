import '../exports.dart';

class DragBottomSheet extends StatelessWidget {
  const DragBottomSheet({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 79.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.samawy, // هنا يمكنك تغيير اللون
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
