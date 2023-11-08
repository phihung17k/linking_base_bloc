import 'package:linking/blocs/base_bloc.dart';
import 'package:linking/blocs/splash/splash_state.dart';

import '../../data/services/i_services/i_splash_service.dart';

class SplashBloc extends BaseBloc<SplashState>{
  final ISplashService _service;
  SplashBloc(this._service) : super(const SplashState());

  void initData() async {
    load(true);
    await _service.initData();
    listener(true);
  }
}