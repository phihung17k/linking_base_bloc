import 'package:flutter/material.dart';
import 'package:linking/blocs/bloc_provider.dart';

import '../../../blocs/home/home_bloc.dart';
import '../../../models/item_model.dart';
import 'item_animated_builder.dart';
import 'item_widget.dart';

class ReorderListWidget extends StatelessWidget {
  final AnimationController? deleteController;

  const ReorderListWidget(this.deleteController, {super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.maybeOf<HomeBloc>(context);
    return StreamBuilder<List<ItemModel>>(
        stream: bloc?.itemsStream,
        builder: (context, snapshot) {
          List<ItemModel>? itemList = snapshot.data;
          return ReorderableListView.builder(
            padding: const EdgeInsets.all(8),
            onReorder: (oldIndex, newIndex) {
              // bug of newIndex in ReorderableListView
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              // bloc.add(
              //     ReorderItemEvent(oldIndex: oldIndex, newIndex: newIndex));
            },
            itemCount: itemList?.length ?? 0,
            itemBuilder: (context, index) {
              var item = itemList?[index];
              return ItemWidget(
                key: ValueKey(item),
                item: item,
                deleteController: deleteController,
              );
            },
            proxyDecorator: (child, index, animation) {
              return ItemAnimatedBuilder(
                key: ValueKey(child),
                animation: animation,
                child: child,
              );
            },
          );
        });
  }
}
