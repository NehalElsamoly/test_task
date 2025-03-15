import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/features/home/data/models/home_model.dart';

import '../../transportation/data/models/get_companies_model.dart';
import '../data/models/home_filter_model.dart';
import '../data/repo/home_repo_impl.dart';
import 'home_state.dart';
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial());
  HomeRepoImpl api;
  int moduleslenth = 3;
  TextEditingController searchController = TextEditingController();

  GetHomeModel homeModel = GetHomeModel();


  GetCompaniesModel transportationFavouriteModel = GetCompaniesModel();
  int selectedIndex=0;

 
}
