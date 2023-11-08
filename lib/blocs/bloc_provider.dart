import 'package:flutter/material.dart';

class BlocProvider<T> extends InheritedWidget {
  final T bloc;

  const BlocProvider({Key? key, required this.bloc, required Widget child})
      : super(key: key, child: child);

  static T? maybeOf<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>()?.bloc;
  }

  static T of<T>(BuildContext context) {
    BlocProvider<T>? provider = maybeOf(context);
    if (provider == null) {
      throw "ERROR: $T is not found";
    }
    // assert(provider != null, "ERROR: $T is not found");
    return provider.bloc;
  }

  @override
  bool updateShouldNotify(covariant BlocProvider<T> oldWidget) {
    return oldWidget.bloc != this.bloc;
  }
}
