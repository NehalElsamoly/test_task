import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/features/home/screens/home_screen.dart';
import 'package:travel_club/features/my_account/screens/about_us.dart';
import 'package:travel_club/features/my_account/screens/account_screen.dart';
import '../../transportation/screens/transportation_map_screen.dart';
import '../data/repo/main_repo_impl.dart';
import 'state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.api) : super(MainInitial());
  MainRepoImpl api;
  List<Widget> screens = [
    const HomeScreen(),
    const TransportationMapScreen(),
    const AboutUs(),
    // const AccountScreen()
  ];
  int currentpage = 0;

  changePage(int index) {
    currentpage = index;
    emit(ChangepageIndex());
  }


}
