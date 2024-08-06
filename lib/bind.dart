import 'dart:async';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

final Injector injector = _GetItImpl();

class Bind {
  static FutureOr<dynamic> dispose<T extends Object>(
      [String? instanceName]) async {
    return await getIt.unregister<T>(instanceName: instanceName);
  }

  static T get<T extends Object>([String? instanceName]) {
    return getIt.get<T>(instanceName: instanceName);
  }

  static bool isRegistered<T extends Object>([String? instanceName]) {
    return getIt.isRegistered<T>(instanceName: instanceName);
  }

  static void registerFactory<T extends Object>(
    String? instanceName,
    T Function() factoryFunction,
  ) {
    getIt.registerFactory<T>(
      factoryFunction,
      instanceName: instanceName,
    );
  }

  static void registerFactoryAsync<T extends Object>(
    String? instanceName,
    Future<T> Function() factoryFunction,
  ) {
    return getIt.registerFactoryAsync<T>(
      factoryFunction,
      instanceName: instanceName,
    );
  }

  static void registerLazySingleton<T extends Object>(
    String? instanceName,
    T Function() factoryFunction,
  ) {
    return getIt.registerLazySingleton<T>(factoryFunction,
        instanceName: instanceName);
  }

  static T registerSingleton<T extends Object>(
    String? instanceName,
    T Function() factoryFunction,
  ) {
    return getIt.registerSingleton<T>(
      factoryFunction(),
      instanceName: instanceName,
    );
  }

  static void registerSingletonAsync<T extends Object>(
    String? instanceName,
    Future<T> Function() factoryFunction,
  ) {
    return getIt.registerSingletonAsync<T>(factoryFunction,
        instanceName: instanceName);
  }
}

abstract class Injector {
  T get<T extends Object>([String? instanceName]);
}

class _GetItImpl implements Injector {
  final GetIt _getIt = GetIt.instance;

  @override
  T get<T extends Object>([String? instanceName]) {
    return _getIt.get<T>(instanceName: instanceName);
  }
}
