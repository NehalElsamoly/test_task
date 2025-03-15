import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/core/preferences/preferences.dart';
import 'package:travel_club/core/utils/appwidget.dart';
import 'package:travel_club/core/utils/restart_app_class.dart';
import 'package:travel_club/features/auth/data/models/login_model.dart';
import '../data/model/get_list_data_model.dart';
import '../data/repo/account_repo_impl.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this.api) : super(AccountInitial());
  AccountRepoImpl api;
  late TextEditingController nameController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController currentPassController = TextEditingController();
  late TextEditingController newpassController = TextEditingController();
  late TextEditingController confirmPassController = TextEditingController();
  // String? selectedLanguage = 'Arabic';
  // First, let's update the changeLanguage method to handle all languages
  void changeLanguage(BuildContext context, String newLanguage) {
    // selectedLanguage = newLanguage; // Update the selected language

    // Map of language display names to their codes
    final Map<String, String> languageCodes = {
      'Arabic': 'ar',
      'English': 'en',
      'German': 'de',
      'Italian': 'it',
      'Korean': 'ko',
      'Russian': 'ru',
      'Spanish': 'es'
    };

    // Get the language code from the map
    final String langCode = languageCodes[newLanguage] ?? 'en';

    // Set the locale
    context.setLocale(Locale(langCode, ''));

    // Save the language preference
    Preferences.instance.savedLang(langCode);

    emit(AccountLanguageChanged()); // Emit a new state to notify the UI
    Preferences.instance.getSavedLang();
    HotRestartController.performHotRestart(context);
  }

  List<GetListDataModel>? dataList ;

  getHomeData() async {
    emit(LoadingData());
    final res = await api.getListData();
    res.fold(
          (l) {
        emit(ErrorGetData());
      },
          (r) {
        dataList = r;
        emit(SucessGetData());
      },
    );
  }

}
// Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3RyYXZlbC50b3BidXNpbmVzcy5lYmhhcmJvb2suY29tL2FwaS92MS9sb2dpbi9nb29nbGUiLCJpYXQiOjE3MzY2Nzk4NzMsImV4cCI6MTc2ODIxNTg3MywibmJmIjoxNzM2Njc5ODczLCJqdGkiOiJha21ja3VoWFhKTFdhamNlIiwic3ViIjoiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.uGiUcBdTaHcm_Wt1irBsXi6-FSp9Gf_n_uV505p43-M