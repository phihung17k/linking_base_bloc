import 'package:flutter/material.dart';
import 'package:linking/blocs/bloc_provider.dart';

import '../../blocs/home/home_bloc.dart';
import '../../blocs/home/home_event.dart';
import '../../system/routes.dart';
import '../base_state.dart';
import 'widgets/floating_button_menu.dart';
import 'widgets/reorder_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc>
    with TickerProviderStateMixin {

  AnimationController? deleteController;
  AnimationController? floatingButtonController;

  // final NetworkConnectivity _networkConnectivity = NetworkConnectivity();
  @override
  void initState() {
    super.initState();

    deleteController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    floatingButtonController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    bloc.listenerStream.listen((event) {
      if (event is NavigatorItemInfoPageForCreatingEvent) {
        Navigator.pushNamed(context, Routes.itemInfo);
      }
      // else if (event is NavigatorItemInfoPageForUpdatingEvent) {
      //   Navigator.pushNamed(context, Routes.itemInfo, arguments: event.item);
      // } else if (event is NavigatorQRSharingPageEvent) {
      //   List<ItemModel> items = bloc.state.selectedIndexList!
      //       .map((index) => bloc.state.itemList![index])
      //       .toList();
      //   Navigator.pushNamed(context, Routes.qrCodeSharing, arguments: items)
      //       .then((value) => bloc.add(ResetSelectedItemsEvent()));
      // } else if (event is NavigatorScannerPageEvent) {
      //   Navigator.pushNamed(context, Routes.scanner, arguments: Routes.home);
      // } else if (event is NavigatorSettingPageEvent) {
      //   Navigator.pushNamed(context, Routes.setting);
      // }
    });

    bloc.reloadAllItem();
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                    AssetImage('assets/images/default_avatar.png'),
                  ),
                  const SizedBox(height: 10),
                  Text("Name",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text("Personal information",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  Flexible(
                    child: ReorderListWidget(deleteController),
                  ),
                ],
              ),
              FloatingButtonMenu(
                key: UniqueKey(),
                deleteController: deleteController,
                floatingButtonController: floatingButtonController,
              )
            ]),
          )),
    );
  }
}
