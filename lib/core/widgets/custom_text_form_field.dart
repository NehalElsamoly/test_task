import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:travel_club/core/exports.dart';
import 'package:intl_phone_field/intl_phone_field.dart' as intl;

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final bool? enabled;
  final String? title;
  final String? hintText;
  final bool isMessage;
  final bool isPassword;
  final bool ischange;
  final bool autoFocus;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPhoneNumber;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String, String)? onPhoneChanged;
// إضافة المتغير
  const CustomTextField(
      {super.key,
      this.labelText,
      this.hintText,
      this.prefixIcon,
      this.validator,
      this.suffixIcon,
      this.keyboardType = TextInputType.text,
      this.isMessage = false,
      this.controller,
      this.initialValue,
      this.onChanged,
      this.onTap,
      this.isPassword = false,
      this.onSubmitted,
      this.borderRadius,
      this.enabled = true,
      this.ischange = false,
      this.title,
      this.autoFocus = false,
      this.isPhoneNumber = false,
      this.onPhoneChanged,
      this.inputFormatters // إضافة المتغير
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode myFocusNode = FocusNode();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: getMediumStyle(
                  color: AppColors.secondPrimary, fontSize: 14.sp),
            ),
            SizedBox(height: 1.h),
          ],
          // إذا كان هو حقل رقم الهاتف
          if (widget.isPhoneNumber)
            _buildPhoneField(context)
          else
            // إذا لم يكن حقل رقم الهاتف، استخدم الحقل العادي
            _buildRegularField(context),
        ],
      ),
    );
  }

  // الحقل المخصص لرقم الهاتف باستخدام مكتبة intl_phone_number_input
  Widget _buildPhoneField(BuildContext context) {
    return Directionality(
      textDirection:
          //trans.EasyLocalization.of(context)!.locale.languageCode == 'en'?
          TextDirection.ltr,
      // TextDirection.rtl,

      //     ? TextAlign.right
      //     : TextAlign.left, TextDirection.ltr,
      child: intl.IntlPhoneField(
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.enabled!
              ? AppColors.lightWhite2
              : AppColors.gray.withOpacity(0.5),
          labelText: widget.labelText,
          labelStyle: getRegularStyle(
            fontHeight: 1.5,
            color: myFocusNode.hasFocus ? AppColors.primary : AppColors.gray,
          ),
          // prefixIcon: widget.prefixIcon,
          //    hintText: widget.hintText,

          // prefixText: widget.hintText,
          // prefixStyle: TextStyle(color: AppColors.white) ,
          //suffixText: widget.hintText,
          // alignLabelWithHint: true,
          hintTextDirection: TextDirection.ltr,
          alignLabelWithHint: true,
          hintStyle:
              getRegularStyle(color: AppColors.secondPrimary, fontSize: 14.sp),
          prefixIconColor:
              myFocusNode.hasFocus ? AppColors.primary : AppColors.gray,
          suffixIconColor:
              myFocusNode.hasFocus ? AppColors.primary : AppColors.gray,
          suffixIcon: widget.ischange
              ? InkWell(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(
                      AppTranslations.change,
                      style: getUnderLine(
                          fontSize: 14.sp, color: AppColors.primary),
                    ),
                  ),
                )
              : widget.isPassword
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: SvgPicture.asset(AppIcons.key),
                      ),
                    )
                  : widget.suffixIcon,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          errorStyle: getRegularStyle(color: AppColors.red),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightWhite, width: 0),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30.r)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray, width: 1.5),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red, width: 1.5),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30.r)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red, width: 1.5),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30.r)),
          ),
        ),

        //   languageCode: 'ar',
        //    initialCountryCode: 'EG', // Change to Egypt or desired default
        // countries: const ['EG', 'SA', 'AE'], // Add relevant country codes
        //  dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        flagsButtonPadding: const EdgeInsets.only(left: 10),
        dropdownTextStyle: TextStyle(fontSize: getWidthSize(context) / 24),
        // textAlign: TextAlign.left,
        dropdownIconPosition: intl.IconPosition.trailing,
        onChanged: (phone) {
          if (widget.onPhoneChanged != null) {
            widget.onPhoneChanged!(phone.countryCode, phone.number);
          }
        },
      ),
    );
  }

  // الحقل العادي المستخدم لبقية البيانات
  Widget _buildRegularField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.0.w),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        onTap: widget.onTap,
        inputFormatters: widget.inputFormatters,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        focusNode: myFocusNode,
        autofocus: widget.autoFocus,
        style: getBoldStyle(fontSize: 13.sp),
        onChanged: widget.onChanged,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        maxLines: widget.isMessage ? 5 : 1,
        minLines: widget.isMessage ? 5 : 1,
        onFieldSubmitted: widget.onSubmitted,
        initialValue: widget.initialValue,
        obscureText: widget.isPassword ? !showPassword : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.enabled!
              ? AppColors.lightWhite2
              : AppColors.gray.withOpacity(0.5),
          labelText: widget.labelText,
          labelStyle: getRegularStyle(
            fontHeight: 1.5,
            color: myFocusNode.hasFocus ? AppColors.primary : AppColors.gray,
          ),
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          hintStyle:
              getRegularStyle(color: AppColors.secondPrimary, fontSize: 14.sp),
          prefixIconColor:
              myFocusNode.hasFocus ? AppColors.primary : AppColors.gray,
          suffixIconColor:
              myFocusNode.hasFocus ? AppColors.primary : AppColors.gray,
          suffixIcon: widget.ischange
              ? InkWell(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(
                      AppTranslations.change,
                      style: getUnderLine(
                          fontSize: 14.sp, color: AppColors.primary),
                    ),
                  ),
                )
              : widget.isPassword
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: SvgPicture.asset(AppIcons.key),
                      ),
                    )
                  : widget.suffixIcon,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          errorStyle: getRegularStyle(color: AppColors.red),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightWhite, width: 0),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30.r)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray, width: 1.5),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red, width: 1.5),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30.r)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.red, width: 1.5),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 30.r)),
          ),
        ),
      ),
    );
  }
}





class CustomPhoneFormField extends StatelessWidget {
  const CustomPhoneFormField({
    super.key,
    this.onCountryChanged,
    this.onChanged,
    this.controller,
    this.title,
    this.enabled = true,
    this.initialValue,
    this.validator, // ✅ دعم الـ Validator
  });

  final void Function(Country)? onCountryChanged;
  final void Function(PhoneNumber)? onChanged;
  final TextEditingController? controller;
  final bool? enabled;
  final String? initialValue;
  final String? title;
  final String? Function(PhoneNumber?)? validator; // ✅ استقباله كـ باراميتر

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: getMediumStyle(
                  color: AppColors.secondPrimary, fontSize: 14.sp),
            ),
            SizedBox(height: 1.h),
          ],
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.0.w),
              child: FormField<PhoneNumber>(
                validator: validator, // ✅ تمرير الـ Validator هنا
                builder: (FormFieldState<PhoneNumber> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntlPhoneField(
                        controller: controller,
                        showCountryFlag: true,
                        dropdownTextStyle: getBoldStyle(fontSize: 13.sp),
                        keyboardType: TextInputType.number,
                        disableLengthCheck: false,
                        showDropdownIcon: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: enabled!
                              ? AppColors.lightWhite2
                              : AppColors.gray.withOpacity(0.5),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          errorStyle: getRegularStyle(
                              color: AppColors.red, fontSize: 13.sp),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: state.hasError ? Colors.red : AppColors.lightWhite, // ✅ تغيير اللون عند الخطأ
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30.r)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: state.hasError ? Colors.red : AppColors.primary, // ✅ تغيير اللون عند الخطأ
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30.r)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.all(Radius.circular(30.r)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.all(Radius.circular(30.r)),
                          ),
                        ),
                        initialValue: initialValue ?? '+20',
                        onCountryChanged: onCountryChanged,
                        onChanged: (phone) {
                          state.didChange(phone); // ✅ تحديث القيمة لتعمل الـ Validator
                          if (onChanged != null) {
                            onChanged!(phone);
                          }
                        },
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
