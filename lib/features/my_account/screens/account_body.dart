import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/features/auth/cubit/cubit.dart';
import 'package:travel_club/features/my_account/screens/widgets/custom_row.dart';
import '../../home/screens/widgets/custom_appbar.dart';
import '../cubit/account_cubit.dart';
import '../cubit/account_state.dart';

class Accountbody extends StatefulWidget {
  const Accountbody({
    super.key,
  });
  @override
  State<Accountbody> createState() => _AccountbodyState();
}

class _AccountbodyState extends State<Accountbody> {
  @override
  Widget build(BuildContext context) {
    AccountCubit cubit = context.read<AccountCubit>();
    return BlocBuilder<AccountCubit, AccountState>(builder: (context, state) {
      return Column(children: [
        SizedBox(height: getVerticalPadding(context) * 2),
        //app bar
        CustomHomeAppbar(
          isHome: false,
          title: AppTranslations.myAccount,
        ),
        // SizedBox(height: 10.h,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //custom container above list view



//list view

                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    // crossAxisAlignment:   CrossAxisAlignment.start,
                    children: [



                      CustomRowProfile(
                        title: AppTranslations.changeLang,
                        onTap: () {
                          Navigator.pushNamed(context, Routes.changeLanguage);
                        },
                      ),


                      CustomRowProfile(
                        title: AppConst.isLogged
                            ? AppTranslations.logout
                            : AppTranslations.login,
                        onTap: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setBool("isLogged", false);
                          print("Saved login state: ${prefs.getBool("ISLOGGED")}");
                         Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.loginRoute, (route) => false);
                        },
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      //  SizedBox(height: 100.h,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]);
    });
  }
}
