import 'package:flutter/material.dart';
import 'package:linking/blocs/blocs.dart';

import '../../blocs/bloc_provider.dart';
import '../../blocs/item_info/item_info_event.dart';
import '../../models/item_model.dart';
import '../base_state.dart';
import 'item_category_sub_page.dart';
import 'item_content_sub_page.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends BaseState<ItemInfoPage, ItemInfoBloc> {
  @override
  void initState() {
    super.initState();
    bloc.initData();

    bloc.listenerStream.listen((event) async {
      if (event is BackingHomePageEvent) {
        Navigator.pop(context, event.isSuccess);
      }
      // else if (event is NavigatorScannerPageEvent) {
      //   var result = await Navigator.pushNamed(context, Routes.scanner,
      //       arguments: Routes.itemInfo);
      //   if (result != null && result is Barcode) {
      //     bloc.add(SetItemFromQrCodeEvent(result));
      //   }
      // }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null && setting.arguments is ItemModel) {
      ItemModel item = setting.arguments as ItemModel;
      bloc.loadingItemFromOtherPageEvent(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.cyan[50],
          appBar: AppBar(
            title: const Text('Settings'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(
                    right: 10, left: 10, bottom: 15, top: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey[300]),
                child: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blue),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Icon(Icons.category),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Category")
                          ])),
                      Tab(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Icon(Icons.info_rounded),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Detail")
                          ]))
                    ]),
              ),
              Expanded(
                child: BlocProvider(
                  bloc: bloc,
                  child: const TabBarView(
                    children: [ItemCategorySubPage(), ItemContentSubPage()],
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
