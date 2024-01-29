// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_localization_bloc.dart';

@immutable
sealed class GlobalLocalizationEvent {}

class ChangeLocalEvent extends GlobalLocalizationEvent {
  final String locale;

  ChangeLocalEvent({required this.locale});
}
