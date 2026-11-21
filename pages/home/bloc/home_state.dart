part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  final List<LibraryItem> items;

  const HomeLoaded(this.items);
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}