part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class ChangeNavSuccessState extends AppState {}

class OnCreateSuccessState extends AppState {}

class OnCreateErrorState extends AppState {}

class OnOpenSuccessState extends AppState {}

class OnOpenErrorState extends AppState {}

class InsertLoadingState extends AppState {}

class InsertSuccessState extends AppState {}

class InsertErrorState extends AppState {}

class DeleteLoadingState extends AppState {}

class DeleteSuccessState extends AppState {}

class DeleteErrorState extends AppState {}

class UpdateLoadingState extends AppState {}

class UpdateSuccessState extends AppState {}

class UpdateErrorState extends AppState {}

class GetLoadingState extends AppState {}

class GetSuccessState extends AppState {}

class GetErrorState extends AppState {}
