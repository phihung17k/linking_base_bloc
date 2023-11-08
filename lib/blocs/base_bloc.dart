import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T extends dynamic> {
  late BehaviorSubject<T> _controller;
  late BehaviorSubject<dynamic> _listenerController;
  late BehaviorSubject<bool> _loadingController;

  BaseBloc(T state) {
    _controller = BehaviorSubject.seeded(state);
    _listenerController = BehaviorSubject.seeded(false);
    _loadingController = BehaviorSubject.seeded(false);
  }

  T get state => _controller.value;

  Sink<T> get _stateSink => _controller.sink;
  Stream<T> get stateStream => _controller.stream;

  Sink<dynamic> get _listener => _listenerController.sink;
  Stream<dynamic> get listenerStream => _listenerController.stream;

  Sink<bool> get _loading => _loadingController.sink;
  Stream<bool> get loadingStream => _loadingController.stream;

  void emit(T state) => _stateSink.add(state);
  void listener(dynamic value) => _listener.add(value);
  void load(bool value) => _loading.add(value);

  @mustCallSuper
  void dispose(){
    _stateSink.close();
    _listener.close();
    _loading.close();

    _controller.close();
    _listenerController.close();
    _loadingController.close();
  }
}
