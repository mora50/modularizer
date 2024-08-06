import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:modularizer/bind_entry.dart';
import 'package:modularizer/bind_manager.dart';

abstract class BaseModule {
  static final BindManager bindManager = BindManager();
  final String rootPath;
  final String? name;
  bool _registered = false;
  final List<BaseModule> subModules;

  final List<BindEntry> bindsList = [];

  BaseModule({
    required this.rootPath,
    this.name,
    this.subModules = const [],
  });

  GoRoute get router => GoRoute(
        name: name,
        path: rootPath,
        onExit: (context, state) async {
          final nextLocation =
              GoRouter.of(context).routeInformationProvider.value.uri;

          final routes = buildRoutes();

          final isInsideOfModule = routes.any(
            (element) => nextLocation.toString().contains(element.path),
          );

          if (isInsideOfModule) {
            return true;
          }

          await dispose();
          return true;
        },
        redirect: (context, state) {
          setup();
          return null;
        },
        builder: (context, state) {
          return buildRoot(context);
        },
        routes: () {
          final modules = subModules.map((module) => module.router).toList();
          return [
            ...buildRoutes(),
            ...modules,
          ];
        }(),
      );

  void binds(BindManager i);

  Widget buildRoot(BuildContext context);

  List<GoRoute> buildRoutes();

  Future<void> dispose() async {
    if (!_registered) return;

    bindManager.disposeAll();

    unregisterDependencies();
    _registered = false;
  }

  void registerDependencies();

  void setup() {
    if (_registered == false) {
      binds(bindManager);
      registerDependencies();
      _registered = true;
    }
  }

  void unregisterDependencies();
}

class BindConfig<T> {
  final void Function(T)? onDispose;

  BindConfig({this.onDispose});
}
