import 'package:modularizer/bind.dart';

class BindEntry<T extends Object> {
  final String? instanceName;
  final void Function(T)? onDispose;

  BindEntry(this.instanceName, this.onDispose);

  Future<void> dispose() async {
    if (onDispose != null) {
      final instance = Bind.get<T>(instanceName);
      onDispose!(instance);
    }

    Bind.dispose<T>(instanceName);
  }
}
