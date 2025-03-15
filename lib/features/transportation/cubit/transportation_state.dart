abstract class TransportationState {}

class TransportationInitial extends TransportationState {}

class DateChangedState extends TransportationState {}

class LoadingSeatChangedState extends TransportationState {}

class SeatChangedState extends TransportationState {}
class ChangeCounterState extends TransportationState {}
class GetCompaniesModelSuccessState extends TransportationState {}
class GetCompaniesModelFailureState extends TransportationState {}
class GetCompaniesModelLoadingState extends TransportationState {}
