import 'package:travel_club/core/exports.dart';
import 'package:travel_club/features/transportation/data/models/add_reservation_model.dart';
import 'package:travel_club/features/transportation/data/models/get_available_busis_model.dart';
import 'package:travel_club/features/transportation/data/models/get_companies_model.dart';
import 'package:travel_club/features/transportation/data/models/get_stations_model.dart';

class TransportationRepoImpl {
  final BaseApiConsumer dio;
  TransportationRepoImpl(this.dio);
  Future<Either<Failure, GetCompaniesModel>> getCompanies(
      {required String lat, required String long}) async {
    try {
      var response = await dio.get(
        EndPoints.getCompaniesUrl,
        queryParameters: {
          "lat": lat,
          "long": long,
        },
      );
      return Right(GetCompaniesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetCompanyStationModel>> getCompanyStations(
      {required String lat,
      required String long,
      required int companyId}) async {
    try {
      var response = await dio.get(
        EndPoints.getCompanyStationUrl,
        queryParameters: {
          "lat": lat,
          "long": long,
          "company_id": companyId,
        },
      );
      return Right(GetCompanyStationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetAvailableBusesModel>> getAvailableBuses(
      {required isGoOnly,
      required String returnDate,
      required String departureDate,
      required int fromCompanySituationId,
      required int toCompanySituationId,
      required int goCounter,
      required int returnCounter,
      required int companyId}) async {
    try {
      var response = await dio.get(
        EndPoints.getAvailableBusesUrl,
        queryParameters: {
          "company_id": companyId,
          "departure_date": departureDate,
          if (!isGoOnly) "return_date": returnDate,
          "from_company_situation_id": fromCompanySituationId,
          "to_company_situation_id": toCompanySituationId,
          "departure_guests": goCounter,
          if (!isGoOnly) "return_guests": returnCounter,
          "is_departure": isGoOnly ? 0 : 1, //0 if isgoOnly 1 if go and return
        },
      );
      return Right(GetAvailableBusesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AddBusReservationModel>> addBusReservation({
    required isGoOnly,
    required String returnDate,
    required String departureDate,
    required int goTimeId,
    required int returnTimeId,
    required int goCounter,
    required int returnCounter,
  }) async {
    try {
      var response = await dio.post(
        EndPoints.addBusReservationUrl,
        body: {
          "departure_date": departureDate,
          if (!isGoOnly) "return_date": returnDate,
          "departure_bus_time_id": goTimeId,
          if (!isGoOnly) "return_bus_time_id": returnTimeId,
          "departure_guests": goCounter,
          if (!isGoOnly) "return_guests": returnCounter,
          "is_departure": isGoOnly ? 0 : 1, //0 if isgoOnly 1 if go and return
        },
      );
      return Right(AddBusReservationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
