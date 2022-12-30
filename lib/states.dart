abstract class NewsState {}


class NewsInitialState extends NewsState{}
class ButtonNavBarState extends NewsState{}
class GetBusinessDataSuccess extends NewsState{}
class GetBusinessDataError extends NewsState{
  late dynamic error;
  GetBusinessDataError(this.error);
}
class GetBusinessDataLoading extends NewsState{}
class GetSportsDataSuccess extends NewsState{}
class GetSportsDataError extends NewsState{
  late dynamic error;
  GetSportsDataError(this.error);
}
class GetSportsDataLoading extends NewsState{}
class GetSciencesDataSuccess extends NewsState{}
class GetSciencesDataError extends NewsState{
  late dynamic error;
  GetSciencesDataError(this.error);
}
class GetSciencesDataLoading extends NewsState{}
class GetSearchDataSuccess extends NewsState{}
class GetSearchDataError extends NewsState{
  late dynamic error;
  GetSearchDataError(this.error);
}
class GetSearchDataLoading extends NewsState{}
