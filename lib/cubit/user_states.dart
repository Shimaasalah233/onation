import 'package:ONATION/cubit/user_cubit.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  String message;
  RegisterSuccessState({required this.message});
}

class FailedToRegisterState extends AuthState {
  String message;
  FailedToRegisterState({required this.message});
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  String message;
  LoginSuccessState({required this.message});
}

class FailedToLoginState extends AuthState {
  final String message;
  FailedToLoginState({required this.message});
}

class DeleteAccountLoadingState extends AuthState {}

class FailedToDeleteAccountState extends AuthState {
  final String message;
  FailedToDeleteAccountState({required this.message});
}

class DeleteAccountSuccessState extends AuthState {
  final String message;
  DeleteAccountSuccessState({required this.message});
}

class AddsuggestionLoadingState extends AuthState {}

class AddsuggestionSuccessState extends AuthState {
  final String message;
  AddsuggestionSuccessState({required this.message});
}

class FaliledtoAddsuggestionState extends AuthState {
  final String message;
  FaliledtoAddsuggestionState({required this.message});
}

class SendEmailSuccessState extends AuthState {
  final String message;
  SendEmailSuccessState({required this.message});
}

class FaliledtoSendEmailState extends AuthState {
  final String message;
  FaliledtoSendEmailState({required this.message});
}

class SendEmailLoadingState extends AuthState {}

class CodeSuccessState extends AuthState {
  final String message;
  CodeSuccessState({required this.message});
}

class FaliledtoCodeState extends AuthState {
  final String message;
  FaliledtoCodeState({required this.message});
}

class CodeLoadingState extends AuthState {}

class SuccesssresetState extends AuthState {
  final String message;
  SuccesssresetState({required this.message});
}

class FailedtoresetState extends AuthState {
  final String message;
  FailedtoresetState({required this.message});
}

class ResetLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {
  final String message;
  LogoutSuccessState({required this.message});
}

class ResendCodeSuccessState extends AuthState {
  final String message;
  ResendCodeSuccessState({required this.message});
}

class FaliledtoresendCodeState extends AuthState {
  final String message;
  FaliledtoresendCodeState({required this.message});
}

class Resendcodeloadingstate extends AuthState {}

class FetchDataLoading extends AuthState {}

class FetchDataSuccess extends AuthState {
  final data;
  FetchDataSuccess({required this.data});
}

class FetchDataFailure extends AuthState {
  final String message;
  FetchDataFailure({required this.message});
}

class FetchaboutusDataLoading extends AuthState {}

class FetchaboutusDataSuccess extends AuthState {
  final data2;
  FetchaboutusDataSuccess({required this.data2});
}

class FetchaboutusDataFailure extends AuthState {
  final String message;
  FetchaboutusDataFailure({required this.message});
}

class ProfileUpdateSuccess extends AuthState {
  final String message;
  ProfileUpdateSuccess({required this.message});
}

class ProfileUpdateFailure extends AuthState {
  final String message;
  ProfileUpdateFailure({required this.message});
}

class PassUpdateSuccess extends AuthState {
  final String message;
  PassUpdateSuccess({required this.message});
}

class PassUpdateFailure extends AuthState {
  final String message;
  PassUpdateFailure({required this.message});
}

class ChangepassLoading extends AuthState {}

class CountryLoaded extends AuthState {
  final List<Country> countries;

  CountryLoaded(this.countries);
}

class CountryError extends AuthState {
  final String message;

  CountryError(this.message);
}

class CountryLoading extends AuthState {}

class SearchSuccess extends AuthState {
  final List<Country> countries;
  SearchSuccess(this.countries);
  /* @override
  List<Object?> get props => [countries];*/
}

class SearchError extends AuthState {
  final String message;
  SearchError(this.message);
}

class SearchLoading extends AuthState {}

class PurposeLoading extends AuthState {}

class PurposeError extends AuthState {
  final String message;
  PurposeError(this.message);
}

class PurposeLoaded extends AuthState {
  final List<Purpose> purposes;

  PurposeLoaded(this.purposes);
}

class CountriescontintLoading extends AuthState {}

class CountriescontientLoaded extends AuthState {
  // final String contintentname;
  final List<dynamic> countries;

  CountriescontientLoaded(this.countries);
}

class CountriescontientError extends AuthState {
  final String message;

  CountriescontientError(this.message);
}
