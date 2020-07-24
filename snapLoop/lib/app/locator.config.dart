// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';

import '../services/Auth.dart';
import '../services/ChatDataService.dart';
import '../services/FABTapped.dart';
import '../services/LoopsDataService.dart';
import '../services/UserDataService.dart';
import '../services/socketService.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

void $initGetIt(GetIt g, {String environment}) {
  final gh = GetItHelper(g, environment);
  gh.lazySingleton<Auth>(() => Auth());
  gh.lazySingleton<ChatDataService>(() => ChatDataService());
  gh.lazySingleton<FABTapped>(() => FABTapped());
  gh.lazySingleton<LoopsDataService>(() => LoopsDataService());
  gh.lazySingleton<SocketService>(() => SocketService());
  gh.lazySingleton<UserDataService>(() => UserDataService());
}
