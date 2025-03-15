import '../../../../core/exports.dart';

class CustomRowProfile extends StatelessWidget {
 const  CustomRowProfile({super.key,required this.title,this.onTap});
 final String? title;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CustomContainerWithShadow(child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: [
              Text(title!),
              Spacer(
              ),
              Icon(Icons.arrow_forward_ios),
            ],),
          )),
        ),
        SizedBox(height: 30.h,)
      ],
    );
  }
}
