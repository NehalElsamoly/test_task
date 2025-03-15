// Finally, let's update the LanguageSelectionScreen class
import 'package:easy_localization/easy_localization.dart';
import 'package:travel_club/core/exports.dart';

import '../../cubit/account_cubit.dart';
import '../../cubit/account_state.dart';

// Now let's update the AppStrings class to include new language codes
// Add these constants to your AppStrings class:
class AppStrings {
  static const String arabicCode = 'ar';
  static const String englishCode = 'en';
  static const String germanCode = 'de';
  static const String italianCode = 'it';
  static const String koreanCode = 'ko';
  static const String russianCode = 'ru';
  static const String spanishCode = 'es';
}
class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (BuildContext context, state) {
        final currentLangCode =
            EasyLocalization.of(context)!.locale.languageCode;

        return SingleChildScrollView(
          child: Column(
            children: [
              buildLanguageOption(
                isSelected: currentLangCode == 'ar',
                title: 'اللغه العربيه',
                value: 'Arabic',
              ),
              SizedBox(height: 16),
              buildLanguageOption(
                isSelected: currentLangCode == 'en',
                title: 'English',
                value: 'English',
              ),
              // SizedBox(height: 16),
              // buildLanguageOption(
              //   isSelected: currentLangCode == 'de',
              //   title: 'Deutsch',
              //   value: 'German',
              // ),
              // SizedBox(height: 16),
              // buildLanguageOption(
              //   isSelected: currentLangCode == 'it',
              //   title: 'Italiano',
              //   value: 'Italian',
              // ),
              // SizedBox(height: 16),
              // buildLanguageOption(
              //   isSelected: currentLangCode == 'ko',
              //   title: '한국어',
              //   value: 'Korean',
              // ),
              // SizedBox(height: 16),
              // buildLanguageOption(
              //   isSelected: currentLangCode == 'ru',
              //   title: 'Русский',
              //   value: 'Russian',
              // ),
              // SizedBox(height: 16),
              // buildLanguageOption(
              //   isSelected: currentLangCode == 'es',
              //   title: 'Español',
              //   value: 'Spanish',
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget buildLanguageOption(
      {required String title,
      required String value,
      required bool isSelected}) {
    var cubit = context.read<AccountCubit>();
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (BuildContext context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              cubit.changeLanguage(context, value);
            },
            child: ListTile(
              leading: Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isSelected ? AppColors.primary : AppColors.grey,
                size: 24.sp,
              ),
              title: Text(
                title,
                style: getMediumStyle(fontSize: 14.sp),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  size: 16.sp, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
