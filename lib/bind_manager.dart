import 'package:modularizer/base_module.dart';
import 'package:modularizer/bind.dart';
import 'package:modularizer/bind_entry.dart';

class BindManager {
  final List<BindEntry> _bindsList = [];

  void addFactory<T extends Object>(
    Function() factoryFunction, {
    String? instanceName,
    BindConfig<T>? config,
  }) {
    instanceName ??= T.toString();

    Bind.registerFactory<T>(instanceName, factoryFunction());
    _bindsList.add(BindEntry<T>(instanceName, config?.onDispose));
  }

  void addLazySingleton<T extends Object>(
    T Function() factoryFunction, {
    String? instanceName,
    BindConfig<T>? config,
  }) {
    instanceName ??= T.toString();
    Bind.registerLazySingleton<T>(instanceName, factoryFunction);
    _bindsList.add(BindEntry<T>(instanceName, config?.onDispose));
  }

  void addSingleton<T extends Object>(
    T Function() factoryFunction, {
    String? instanceName,
    BindConfig<T>? config,
  }) {
    Bind.registerSingleton<T>(
      instanceName,
      factoryFunction,
    );
    _bindsList.add(BindEntry<T>(instanceName, config?.onDispose));
  }

  Future<void> disposeAll() async {
    for (final entry in _bindsList) {
      entry.dispose();
    }
    _bindsList.clear();
  }

  T get<T extends Object>({String? instanceName}) {
    return Bind.get<T>(instanceName);
  }
}
