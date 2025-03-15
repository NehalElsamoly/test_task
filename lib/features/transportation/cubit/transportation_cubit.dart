import 'package:easy_localization/easy_localization.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/core/utils/appwidget.dart';
import 'package:travel_club/features/location/cubit/location_cubit.dart';
import 'package:travel_club/features/transportation/data/models/add_reservation_model.dart';
import 'package:travel_club/features/transportation/data/models/get_available_busis_model.dart';
import 'package:travel_club/features/transportation/data/models/get_companies_model.dart';
import 'package:travel_club/features/transportation/data/models/get_stations_model.dart';
import '../data/repo/transportation_repo_impl.dart';
import 'transportation_state.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';

class TransportationCubit extends Cubit<TransportationState> {
  TransportationCubit(this.api) : super(TransportationInitial());
  TransportationRepoImpl api;

  bool isGoOnly = true; // isOnly send single date else send drom and to

  void changeGoOnly(bool value) {
    isGoOnly = value;
    emit(TransportationInitial());
  }

  int goCounter = 1;
  int returnCounter = 1;
  int goAndReturnDifference() {
    int difference = returnCounter - goCounter;
    return difference > 0
        ? difference
        : -difference; // Ensure the result is positive
  }

  int getRoundTripsCounter() {
    if (goCounter <= returnCounter) {
      return goCounter;
    } else {
      return returnCounter;
    }
  }

  void changeCounter({required bool isPlus, required bool isReturn}) {
    if (isReturn) {
      if (isPlus) {
        returnCounter = returnCounter + 1;
      } else {
        if (returnCounter > 1) {
          returnCounter = returnCounter - 1;
        }
      }
    } else {
      if (isPlus) {
        goCounter = goCounter + 1;
      } else {
        if (goCounter > 1) {
          goCounter = goCounter - 1;
        }
      }
    }
    emit(ChangeCounterState());
  }

  ///// from and to cities
  bool isFavoriteTrue = false;
  StationModel? selectedFromStation;
  StationModel? selectedToStation;

  void changeStationValue(StationModel value, bool isFrom) {
    print("Selected Station ID: ${value.id}");
    print("Current Selected From Station ID: ${selectedFromStation?.id}");
    print("Current Selected To Station ID: ${selectedToStation?.id}");
    // if ((isFrom &&
    //         selectedToStation != null &&
    //         value.id == selectedToStation?.id) ||
    //     (!isFrom && selectedFromStation != null &&
    //         value.id == selectedFromStation?.id)) {
    //   print("You cannot select the same station.");
    //   errorGetBar(AppTranslations.youCanNotSelectSameStation);

    //   // Reset the corresponding station
    //   if (isFrom) {
    //     selectedFromStation = null;
    //   } else {
    //     selectedToStation = null;
    //   }
    // } else {
    // Set the station based on isFrom
    if (isFrom) {
      selectedFromStation = value;
    } else {
      selectedToStation = value;
    }
    // }

    // Emit the updated state
    emit(TransportationInitial());
  }

  DateTime selectedStartDate = DateTime.now();
// Initialize end date to next day by default
  DateTime selectedEndDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String fromDate = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
  String toDate = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
  String singleDate = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());

  setEndDatePlusOneDay() {
    selectedEndDate = DateTime.now().add(const Duration(days: 1));
    toDate = DateFormat('yyyy-MM-dd', 'en').format(selectedEndDate);
    selectedStartDate = DateTime.now();
    fromDate = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());

    //updateDateStrings();
  }



  // 13 >> 50 seats
  // 11 >>43
  int seatRowsCount = 13;
  List<int> reservedSeats = [1, 4, 5, 22, 25, 26, 55, 41];
  List<int> selectedSeats = [];

  void selectSeat(int seatNumber) {
    if (selectedSeats.contains(seatNumber)) {
      selectedSeats.remove(seatNumber);
    } else {
      selectedSeats.add(seatNumber);
    }
    emit(SeatChangedState());
  }

  String convertToEnglishDigits(String input) {
    const Map<String, String> arabicToEnglishDigits = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };
    String output = input;
    arabicToEnglishDigits.forEach((arabic, english) {
      output = output.replaceAll(arabic, english);
    });

    return output;
  }

  //get Companies
  GetCompaniesModel getCompaniesModel = GetCompaniesModel();
  getCompanies(BuildContext context) async {
    //getCompaniesModel = GetCompaniesModel();
    emit(GetCompaniesModelLoadingState());
    final res = await api.getCompanies(
      lat: (context.read<LocationCubit>().selectedLocation?.latitude ?? 0.0)
          .toString(),
      long: (context.read<LocationCubit>().selectedLocation?.longitude ?? 0.0)
          .toString(),
    );
    res.fold((l) {
      emit(GetCompaniesModelFailureState());
    }, (r) {
      getCompaniesModel = r;
      emit(GetCompaniesModelSuccessState());
    });
  }

  //get Company Stations
  GetCompanyStationModel getCompanyStationsiesModel = GetCompanyStationModel();
  getCompanyStations(BuildContext context, {required int companyId}) async {
    getCompanyStationsiesModel = GetCompanyStationModel();
    selectedFromStation = null;
    selectedToStation = null;
    emit(GetCompaniesModelLoadingState());
    final res = await api.getCompanyStations(
      lat: (context.read<LocationCubit>().selectedLocation?.latitude ?? 0.0)
          .toString(),
      long: (context.read<LocationCubit>().selectedLocation?.longitude ?? 0.0)
          .toString(),
      companyId: companyId,
    );
    res.fold((l) {
      emit(GetCompaniesModelFailureState());
    }, (r) {
      if (r.data!.isNotEmpty) {
        selectedFromStation = r.data!.first;
        // selectedToStation = r.data!.last;
      }
      getCompanyStationsiesModel = r;
      emit(GetCompaniesModelSuccessState());
    });
  }

  //get Company Stations
  GetAvailableBusesModel getAvailableBusesModel = GetAvailableBusesModel();
  getAvailableBuses(BuildContext context, {required int companyId}) async {
    AppWidget.createProgressDialog(context, AppTranslations.loading);

    emit(GetCompaniesModelLoadingState());
    final res = await api.getAvailableBuses(
      isGoOnly: isGoOnly,
      returnDate: toDate,
      departureDate: isGoOnly ? singleDate : fromDate,
      fromCompanySituationId: selectedFromStation!.id!,
      toCompanySituationId: selectedToStation!.id!,
      goCounter: goCounter,
      returnCounter: returnCounter,
      companyId: companyId,
    );
    res.fold((l) {
      Navigator.pop(context);
      errorGetBar(AppTranslations.error);
      emit(GetCompaniesModelFailureState());
    }, (r) {
      Navigator.pop(context);
      if (r.data!.isNotEmpty) {
        getAvailableBusesModel = r;
        for (var element in getAvailableBusesModel.data!) {
          element.selectedGoTime = element.busTimeInDeparture?.first;
          print("selectedGoTime: ${element.selectedGoTime?.fromTime}");
          if (!isGoOnly) {
            element.selectedReturnTime = element.busTimeInReturn?.first;
            print(
                "selectedReturnTime: ${element.selectedReturnTime?.fromTime}");
          }
        }
        Navigator.pushNamed(context, Routes.transportationSearchResultRoute);
      } else {
        errorGetBar(AppTranslations.noBusesFound);
      }
      emit(GetCompaniesModelSuccessState());
    });
  }

  AddBusReservationModel addBusReservationModel = AddBusReservationModel();
  addBusReservation(BuildContext context,
      {required int returnTimeId,
      required int goTimeId,
      required BusCompanyModel busCompanyModel}) async {
    AppWidget.createProgressDialog(context, AppTranslations.loading);

    emit(GetCompaniesModelLoadingState());
    final res = await api.addBusReservation(
      isGoOnly: isGoOnly,
      returnDate: toDate,
      departureDate: isGoOnly ? singleDate : fromDate,
      goTimeId: goTimeId,
      returnTimeId: returnTimeId,
      goCounter: goCounter,
      returnCounter: returnCounter,
    );
    res.fold((l) {
      Navigator.pop(context);
      errorGetBar(AppTranslations.error);
      emit(GetCompaniesModelFailureState());
    }, (r) {
      Navigator.pop(context);
      if (r.data != null) {
        addBusReservationModel = r;
        Navigator.pushNamed(context, Routes.tripDetailsSecondRoute,
            arguments: busCompanyModel);
      } else {
        errorGetBar(r.msg ?? AppTranslations.error);
      }
      emit(GetCompaniesModelSuccessState());
    });
  }

  int selectedFromStationTimeId = 0;
  int selectedToStationTimeId = 0;
  setStationTimeId(int id, bool isFrom) {
    isFrom ? selectedFromStationTimeId = id : selectedToStationTimeId = id;
    emit(TransportationInitial());
  }
}
// "24.713599999999975","longitude":"46.66431367187498"
