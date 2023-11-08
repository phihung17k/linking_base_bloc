import 'package:flutter/material.dart';
import 'package:linking/blocs/splash/splash_bloc.dart';

import '../../system/routes.dart';
import '../base_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashBloc> {

  @override
  void initState() {
    super.initState();

    bloc.listenerStream.listen((event) {
      if(event == true){
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    });

    bloc.initData();
  }
  @override
  Widget buildContent(BuildContext context) {
    return const Scaffold();
  }
}
