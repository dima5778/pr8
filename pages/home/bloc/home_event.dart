part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

final class LoadLibraryEvent extends HomeEvent {
  const LoadLibraryEvent();
}