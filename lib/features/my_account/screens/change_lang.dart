import 'package:travel_club/features/my_account/screens/widgets/custom_container_radio.dart';

import '../../../core/exports.dart';
import '../cubit/account_cubit.dart';
import '../cubit/account_state.dart';

class ChangeLang extends StatelessWidget {
  const ChangeLang({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=context.read<AccountCubit>();
    return BlocBuilder<AccountCubit, AccountState>(builder: (BuildContext context, state) {
      return CustomScreen(
        appbarTitle: AppTranslations.changeLang,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: getVerticalPadding(context) * 2,),
              LanguageSelectionScreen()
              // Radio(value: false, onChanged: (value){}, groupValue: false,activeColor: AppColors.primary,),
            ],
          ),
        )
    ); },);
  }
}
