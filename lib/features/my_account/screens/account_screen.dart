
import 'package:travel_club/core/exports.dart';
import '../cubit/account_cubit.dart';
import '../cubit/account_state.dart';
import 'account_body.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AccountCubit cubit = context.read<AccountCubit>();
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return Scaffold(body: Accountbody());
      },
    );
  }
}