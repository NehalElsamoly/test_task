import 'package:flutter/material.dart';
import 'package:travel_club/core/exports.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final FormFieldValidator<String?>? validator; // ✅ إضافة الـ Validator

  const CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = "Select Option",
    this.validator, // ✅ استقباله كـ باراميتر
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator, // ✅ تمرير validator للتحقق من الإدخال
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: AppColors.lightBlue1.withOpacity(.5),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: state.hasError ? Colors.red : AppColors.greyborder, // 🔴 لون أحمر عند الخطأ
                  width: 1.5,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  hint: Text(
                    hintText,
                    style: TextStyle(color: AppColors.blackLite, fontSize: 16),
                  ),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    onChanged(newValue);
                    state.didChange(newValue); // ✅ تحديث حالة الـ FormField
                  },
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.grey),
                  dropdownColor: Colors.white,
                ),
              ),
            ),
            if (state.hasError) // ✅ عرض رسالة الخطأ
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 16.0),
                child: Text(
                  state.errorText ?? "",
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }
}
