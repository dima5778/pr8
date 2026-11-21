import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/library_repository.dart';
import '../../../models/library_item.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LibraryRepository _repository;

  HomeBloc(this._repository) : super(const HomeInitial()) {
    on<LoadLibraryEvent>(_onLoadLibrary);
  }

  Future<void> _onLoadLibrary(
      LoadLibraryEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(const HomeLoading());

    try {
      final items = await _repository.getAll();
      emit(HomeLoaded(items));
    } catch (error) {
      emit(const HomeError('Не удалось загрузить данные из базы данных'));
    }
  }
}