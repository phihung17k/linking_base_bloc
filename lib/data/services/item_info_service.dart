import '../../models/item_category_model.dart';
import '../../utils/file_util.dart';
import '../repositories/repositories.dart';
import 'i_services/i_item_info_service.dart';

class ItemInfoService implements IItemInfoService {
  final IAppRepository _appRepository;

  ItemInfoService(this._appRepository);

  @override
  Future<List<ItemCategoryModel>> getAllItemCategory() async {
    try {
      // get from db
      var categories = await _queryCategoriesInDB();
      if (categories.isNotEmpty) {
        return categories.map((ic) => ItemCategoryModel.fromMap(ic)).toList();
      } else {
        // get from asset when db empty
        var rawCategories = await FileUtil.loadCategoriesJson();
        var rawCategoriesMap = rawCategories.map((ic) => ic.toMap()).toList();
        bool isInserted = await _appRepository.insertBatch(
            DatabaseHelper.itemCategory, rawCategoriesMap);

        if (isInserted) {
          var categories = await _queryCategoriesInDB();
          return categories.map((ic) => ItemCategoryModel.fromMap(ic)).toList();
        }
      }
    } catch (e) {
      throw Exception(e);
    }
    return [];
  }

  Future<List<Map<String, Object?>>> _queryCategoriesInDB() async {
    return await _appRepository.queryAll(DatabaseHelper.itemCategory);
  }

  @override
  Future<bool> addItem(Map<String, Object?> values) async {
    try {
      int id = await _appRepository.insert(DatabaseHelper.item, values);
      return id != 0;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateItem(Map<String, Object?> values) async {
    try {
      int id = await _appRepository.update(DatabaseHelper.item, values);
      return id != 0;
    } catch (e) {
      throw Exception(e);
    }
  }
}