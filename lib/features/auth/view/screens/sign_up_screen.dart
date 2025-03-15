import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/features/auth/cubit/cubit.dart';
import 'package:travel_club/features/auth/cubit/state.dart';
import 'package:travel_club/features/auth/view/widgets/custom_container.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/custom_forward.dart';
import '../widgets/custom_title.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
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
            body: Form(
              key: formKeySignUp,
              child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                     CustomBackContainer(),
                      SizedBox(
                        height: 10.h,
                      ),
                      //title
                      CustomTitle(
                        title: AppTranslations.signUp,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                          controller: cubit.userNameSignUp,
                          enabled: true,
                          title: "username".tr(),
                          hintText: "enter_username".tr(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppIcons.profile),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please_enter_username".tr();
                            }
                            return null;
                          }),
                      CustomTextField(
                          controller: cubit.nameController,
                          enabled: true,
                          title: AppTranslations.fullName,
                          hintText: AppTranslations.writeFullName,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppIcons.profile),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppTranslations.writeFullName;
                            }
                            return null;
                          }),  CustomTextField(
                          controller: cubit.emailControllerSignUp,
                          enabled: true,
                          title:"email".tr(),
                          hintText:"enter_email".tr(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.email, color: AppColors.primary,),
                          ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "enter_email".tr();
                          }
                          // ✅ التحقق من وجود @ والتحقق من البريد الإلكتروني بصيغة صحيحة
                          String emailPattern =
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
                          RegExp regex = RegExp(emailPattern);
                          if (!regex.hasMatch(value)) {
                            return "please_enter_a_valid_email".tr(); // رسالة خطأ عند الإدخال غير الصحيح
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 1.h,),
                      CustomPhoneFormField(
                        controller: cubit.phoneControllerSignUp,
                        initialValue: cubit.countryCode,
                        title: AppTranslations.phone,
                        onCountryChanged: (v) {
                          cubit.countryCode = '+${v.fullCountryCode}';
                          print("Country changed to: ${v.name}");
                        },
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                        validator: (value) {
                          if (value == null || value.number.isEmpty) {
                            return "enter_phone".tr();
                          }
                          if (value.number.length < 8) {
                            return "Phone number is too short";
                          }
                          if (value.number.length > 15) {
                            return "Phone number is too long";
                          }
                          return null;
                        },
                      ),
                  
                      CustomTextField(
                        controller: cubit.passwordControllerSignUp,
                        enabled: true,
                        isPassword: true,
                        title: AppTranslations.pass,
                        hintText: AppTranslations.writePass,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return AppTranslations.passIsRequired;
                          } else if (v.length < 8) {
                            return AppTranslations.passLength;
                          }
                          return null;
                        },
                      ),

                      //forward
                      Center(
                        child: CustomForward(
                          onTap: () async {
                            if (formKeySignUp.currentState!.validate()) {
                              debugPrint("Logged in successfully");
                              SharedPreferences prefs = await SharedPreferences
                                  .getInstance();
                              await prefs.setBool("isLogged", true);
                              print("Saved login state: ${prefs.getBool(
                                  "isLogged")}");

                              Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.mainRoute, (route) => false);
                            }
                          }),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                  //social
                      //SocialLoginRow(),
                      SizedBox(
                        height: 20.h,
                      ),
                      //terms
                      Column(
                        children: [
                          Center(
                              child: Text(AppTranslations.termsAndConditions,
                                  style: getMediumStyle(fontSize: 12.sp))),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Center(
            //   child: ElevatedButton(
            //       onPressed: () {
            //         Navigator.pushReplacementNamed(context, Routes.mainRoute);
            //       },
            //       child: const Text('Nav To Main Screen')),
            // ),
          ),
        );
      },
    );
  }
}

