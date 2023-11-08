import 'package:flutter/material.dart';
import 'package:linking/blocs/bloc_provider.dart';

import '../../../blocs/item_info/item_info_bloc.dart';
import '../../../models/item_category_model.dart';

class ItemCategoryWidget extends StatelessWidget {
  final ItemCategoryModel selectedCategory;

  const ItemCategoryWidget({
    super.key,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.maybeOf<ItemInfoBloc>(context);
    return GestureDetector(
      onTap: () {
        bloc!.selectingCategory(selectedCategoryId: selectedCategory.id);
      },
      child: StreamBuilder<int>(
          stream: bloc?.selectedItemIdStream,
          builder: (context, snapshot) {
            return Card(
              elevation: 2,
              shape: snapshot.hasData && snapshot.data == selectedCategory.id
                  ? const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue, width: 3))
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Image.asset(selectedCategory.image!),
                      ),
                      const SizedBox(height: 5),
                      Text(selectedCategory.name!)
                    ]),
              ),
            );
          }),
    );
  }
}
