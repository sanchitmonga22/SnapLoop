// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../services/Auth.dart';
import '../services/ChatDataService.dart';
import '../services/ConnectionService.dart';
import '../services/FABTapped.dart';
import '../services/LoopsDataService.dart';
import '../services/socketService.dart';
import '../services/StorageService.dart';
import '../services/UserDataService.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<Auth>(() => Auth());
  gh.lazySingleton<ChatDataService>(() => ChatDataService());
  gh.lazySingleton<ConnectionStatusService>(() => ConnectionStatusService());
  gh.lazySingleton<FABTapped>(() => FABTapped());
  gh.lazySingleton<LoopsDataService>(() => LoopsDataService());
  gh.lazySingleton<SocketService>(() => SocketService());
  gh.lazySingleton<StorageService>(() => StorageService());
  gh.lazySingleton<UserDataService>(() => UserDataService());
  return get;
}
