import 'package:flutter/material.dart';
import 'package:linking/blocs/bloc_provider.dart';
import 'package:linking/pages/loading_widget.dart';

import '../../blocs/item_info/item_info_bloc.dart';
import '../../models/item_category_model.dart';
import 'widgets/item_category_widget.dart';

class ItemCategorySubPage extends StatefulWidget {
  const ItemCategorySubPage({super.key});

  @override
  State<ItemCategorySubPage> createState() => _ItemCategorySubPageState();
}

class _ItemCategorySubPageState extends State<ItemCategorySubPage> {
  late ItemInfoBloc bloc;

  @override
  void initState() {
    super.initState();
    debugPrint("ItemCategorySubPage initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("ItemCategorySubPage didChangeDependencies");
    bloc = BlocProvider.maybeOf<ItemInfoBloc>(context)!;
  }

  @override
  void didUpdateWidget(ItemCategorySubPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("ItemCategorySubPage didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint("ItemCategorySubPage deactivate");
  }

  @override
  void activate() {
    super.activate();
    debugPrint("ItemCategorySubPage activate");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("ItemCategorySubPage dispose");
  }

  List<List<ItemCategoryModel>> getCategoryTopics(
      List<ItemCategoryModel> itemCategories) {
    List<List<ItemCategoryModel>> results = [];
    String topic = itemCategories[0].topic!;
    List<ItemCategoryModel> tempList = [];
    for (var category in itemCategories) {
      if (category.topic == topic) {
        tempList.add(category);
      } else {
        results.add(tempList.toList());
        tempList.clear();
        topic = category.topic!;
        tempList.add(category);
      }
    }
    results.add(tempList);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ItemCategorySubPage build");
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: StreamBuilder<List<ItemCategoryModel>>(
        initialData: const [],
        stream: bloc.itemCategoriesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const LoadingWidget();
          }
          var topics = getCategoryTopics(snapshot.data!);
          return ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, indexCategory) {
              List<ItemCategoryModel> categories = topics[indexCategory];
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(categories.first.topic!,
                      style: Theme.of(context).textTheme.titleLarge),
                  const Divider(thickness: 2),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 8 / 7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, indexItem) {
                      return ItemCategoryWidget(
                          selectedCategory: categories[indexItem]);
                    },
                  ),
                  const SizedBox(height: 20)
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: toString(),
          onPressed: () {
            DefaultTabController.of(context).animateTo(1);
          },
          child: const Icon(Icons.keyboard_double_arrow_right_rounded)),
    );
  }

}
