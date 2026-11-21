// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:prac2/data/app_database.dart' as _i995;
import 'package:prac2/data/library_repository.dart' as _i606;
import 'package:prac2/pages/home/bloc/home_bloc.dart' as _i938;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i995.AppDatabase>(() => _i995.AppDatabase());
    gh.lazySingleton<_i606.LibraryRepository>(
      () => _i606.LibraryRepository(gh<_i995.AppDatabase>()),
    );
    gh.factory<_i938.HomeBloc>(
      () => _i938.HomeBloc(gh<_i606.LibraryRepository>()),
    );
    return this;
  }
}
