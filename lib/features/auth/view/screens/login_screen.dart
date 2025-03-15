import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/core/utils/app_colors.dart';
import 'package:travel_club/core/widgets/dropdown_button_form_field.dart';
import 'package:travel_club/features/auth/cubit/cubit.dart';
import 'package:travel_club/features/auth/cubit/state.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/widgets/custom_skip_row.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/custom_forward.dart';
import '../widgets/custom_title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
 @override
  void initState() {
//context.read<LoginCubit>().signOutFromGmail();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (BuildContext context, state) {
        return SafeArea(
          child: Scaffold(
            //  backgroundColor: AppColors.white,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKeyLogin,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.locale.languageCode == 'ar'
                                  ? "change_language_to_English".tr()
                                  : "change_language_to_Arabic".tr(),
                              style: getSemiBoldStyle(
                                color: AppColors.secondPrimary,
                                fontSize: 14.sp,
                              ),
                            ),
                            Switch(
                              value: context.locale.languageCode == 'en', // تحقق من اللغة الحالية
                              onChanged: (bool value) {
                                String newLanguage = value ? 'English' : 'Arabic'; // تحديد اللغة الجديدة
                                context.read<LoginCubit>().changeLanguage(context, newLanguage); // استدعاء الدالة الخاصة بتغيير اللغة
                              },
                              activeColor: AppColors.primary,
                              focusColor: AppColors.greyborder,
                              inactiveTrackColor: AppColors.greyborder,
                              // inactiveThumbColor: AppColors.greyborder,
                              // لون الزر عند التفعيل
                            ),
                          ],
                        ),
                      ),


                      // CustomContainer(),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomTitle(
                        title: AppTranslations.login,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),

                      CustomTextField(
                        controller: cubit.userNameController,
                        enabled: true,
                     //   isPassword: true,
                        title:"username".tr(),
                        hintText: "enter_username".tr(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please_enter_username".tr();
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomTextField(
                        controller: cubit.passwordControllerLogin,
                        enabled: true,
                        isPassword: true,
                        title: AppTranslations.pass,
                        hintText: AppTranslations.writePass,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please_enter_password".tr();
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                  Text("choose_user_type".tr(),style:getMediumStyle(
                      color: AppColors.secondPrimary, fontSize: 14.sp),
                  ),
                      SizedBox(height: 1.h),

                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 8.0.h ,horizontal: 3.0.w),
                        child: CustomDropdown(
                                            items: ["Admin", "User"],
                                            value: cubit.selectedUserType??"Admin",
                                            hintText: "Select User Type",
                                            onChanged: (newValue) {
                        cubit.updateUserType(newValue);
                                            },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select a user type";
                            }
                            return null;
                          },
                                          ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),

                      CustomButton(
                        title: "login".tr(),
                        onTap: () async {
                          if (formKeyLogin.currentState!.validate()) {
                            debugPrint("Logged in successfully");
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setBool("isLogged", true);
                            print("Saved login state: ${prefs.getBool("isLogged")}");

                            Navigator.pushNamedAndRemoveUntil(context, Routes.mainRoute, (route) => false);
                          }
                        },
                      ),


                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppTranslations.havenotAccount,
                            style: getSemiBoldStyle(
                                color: AppColors.secondPrimary,
                                fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.signUp);
                              },
                              child: Text(
                                AppTranslations.createNewAccount,
                                style: getUnderLine(
                                  fontSize: 14.sp,
                                  color: AppColors.primary,
                                  fontweight: FontWeight.w500,
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

          ),
        );
      },
    );
  }
}
