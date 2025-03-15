import 'package:travel_club/core/exports.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final dynamic value;
  final String? hint;
  final ValueChanged<dynamic>? onChanged;
  final FormFieldValidator<dynamic>? validator;
// items.map((String item) {
//           return DropdownMenuItem<String>(
//             value: item,
//             child: Text(item),
//           );
//         }).toList()
  const CustomDropdownButtonFormField({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DropdownButtonFormField<dynamic>(
        icon: Container(),
        value: value,
        decoration: InputDecoration(
          hintText: hint ?? "اختر",
          contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey1, width: 1.5),
            // borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          hintStyle: getRegularStyle(
            color: AppColors.grey1,
            fontSize: 15.sp,
            fontHeight: 2,
          ),
          errorStyle: getRegularStyle(color: AppColors.red),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey1, width: 1.5),
            // borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey1, width: 1.5),
            // borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey1, width: 1.5),
            // borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey1, width: 1.5),
            // borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey1, width: 1.5),
            // borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          suffixIcon: Padding(
            padding:
                EdgeInsets.only(right: 8.w), // Adjust padding for alignment
            child: Icon(
              Icons.expand_more_rounded, // Suffix icon
              color: AppColors.grey1,
            ),
          ),
        ),
        alignment: Alignment.bottomCenter,
        items: items,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
