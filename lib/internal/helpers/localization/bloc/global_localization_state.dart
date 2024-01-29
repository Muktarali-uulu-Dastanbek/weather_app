// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_localization_bloc.dart';

@immutable
sealed class GlobalLocalizationState {}

final class GlobalLocalizationInitialState extends GlobalLocalizationState {}

class GlobalLocalizationLadingState extends GlobalLocalizationState {}

class GlobalLocalizationLadedState extends GlobalLocalizationState {
  final String locale;

  GlobalLocalizationLadedState({required this.locale});
}

class GlobalLocalizationErrorState extends GlobalLocalizationState {
  final CatchException error;

  GlobalLocalizationErrorState({required this.error});
}
