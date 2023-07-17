// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../services/Auth.dart' as _i3;
import '../services/ChatDataService.dart' as _i4;
import '../services/CloudMessagingService.dart' as _i5;
import '../services/ConnectionService.dart' as _i6;
import '../services/FABTapped.dart' as _i7;
import '../services/LoopsDataService.dart' as _i8;
import '../services/socketService.dart' as _i9;
import '../services/StorageService.dart' as _i10;
import '../services/UserDataService.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.Auth>(() => _i3.Auth());
  gh.lazySingleton<_i4.ChatDataService>(() => _i4.ChatDataService());
  gh.lazySingleton<_i5.CloudMessagingService>(
      () => _i5.CloudMessagingService());
  gh.lazySingleton<_i6.ConnectionStatusService>(
      () => _i6.ConnectionStatusService());
  gh.lazySingleton<_i7.FABTapped>(() => _i7.FABTapped());
  gh.lazySingleton<_i8.LoopsDataService>(() => _i8.LoopsDataService());
  gh.lazySingleton<_i9.SocketService>(() => _i9.SocketService());
  gh.lazySingleton<_i10.StorageService>(() => _i10.StorageService());
  gh.lazySingleton<_i11.UserDataService>(() => _i11.UserDataService());
  return get;
}
