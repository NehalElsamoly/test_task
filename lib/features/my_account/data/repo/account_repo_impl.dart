import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:travel_club/features/auth/data/models/default_model.dart';
import 'package:travel_club/features/auth/data/models/login_model.dart';

import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/preferences/preferences.dart';
import '../model/get_list_data_model.dart';

class AccountRepoImpl {
  final BaseApiConsumer dio;
  AccountRepoImpl(this.dio);
  Future<Either<Failure, List<GetListDataModel>>> getListData() async {
    LoginModel user = await Preferences.instance.getUserModel();
    try {
      var response = await dio.get("https://jsonplaceholder.typicode.com/posts");

      List<GetListDataModel> dataList = (response as List)
          .map((item) => GetListDataModel.fromJson(item))
          .toList();

      return Right(dataList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }


}
