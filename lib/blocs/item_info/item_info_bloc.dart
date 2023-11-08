import '../../data/services/i_services/i_item_info_service.dart';
import '../../models/models.dart';
import '../../utils/general_util.dart';
import '../base_bloc.dart';
import 'item_info_event.dart';
import 'item_info_state.dart';

class ItemInfoBloc extends BaseBloc<ItemInfoState> with GeneralUtil {
  final IItemInfoService _service;

  ItemInfoBloc(this._service)
      : super(const ItemInfoState(itemCategories: [], selectedCategoryId: 1));

  Stream<List<ItemCategoryModel>> get itemCategoriesStream =>
      stateStream.map((state) => state.itemCategories!).distinct();

  Stream<int> get selectedItemIdStream =>
      stateStream.map((state) => state.selectedCategoryId!).distinct();

  Stream<String> get networkEncryptionStream =>
      stateStream.map((state) => state.networkEncryption!).distinct();

  Stream<ItemModel> get itemStream =>
      stateStream.map((state) => state.item!).distinct();

  void initData() async {
    load(true);
    List<ItemCategoryModel> itemCategories =
        await _service.getAllItemCategory();
    ItemCategoryModel category = itemCategories.first;
    emit.call(state.copyWith(
        itemCategories: itemCategories,
        item:
            state.item ?? ItemModel(name: category.name, category: category)));
    load(false);
  }

  void selectingCategory({int? selectedCategoryId}) {
    if (selectedCategoryId != state.selectedCategoryId) {
      ItemCategoryModel category = state.itemCategories!
          .firstWhere((ic) => ic.id == selectedCategoryId!);
      emit.call(state.copyWith(
        selectedCategoryId: category.id,
        item: state.item!.copyWith(
          name: category.name,
          category: category,
        ),
      ));
    }
  }

  void setNetworkEncryption(String? encryption) {
    if (encryption != state.networkEncryption) {
      emit(state.copyWith(networkEncryption: encryption));
    }
  }

  //#region setItemInfo
  void setItemInfo(SetItemInfoEvent event) async {
    ItemModel item = state.item!;
    String? name = event.name;
    if (name == null || name.trim().isEmpty) {
      name = item.category!.name;
    }

    item = handleCategorCase(item.category!.name!, params: [item, name, event])
        as ItemModel;

    bool result = false;
    if (item.id == null) {
      result = await _service.addItem(item.toMap());
    } else {
      result = await _service.updateItem(item.toMap());
    }
    listener(BackingHomePageEvent(result));
  }

  @override
  Object? onSms({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name,
        sms: SmsModel(phoneNumber: event.phoneNumber, message: event.message));
  }

  @override
  Object? onUrl({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name, url: UrlModel(url: event.url));
  }

  @override
  Object? onPhone({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name,
        phone: PhoneModel(phoneNumber: event.phoneNumber));
  }

  @override
  Object? onEmail({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name,
        email: EmailModel(
            address: event.address,
            cc: event.cc,
            bcc: event.bcc,
            subject: event.subject,
            body: event.body));
  }

  @override
  Object? onWifi({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name,
        wifi: WifiModel(
            networkName: event.networkName,
            password: event.password,
            encryption: state.networkEncryption,
            isHidden: false));
  }

  @override
  Object? onLink({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    String name = params[1] as String;
    var event = params[2] as SetItemInfoEvent;
    return _getUpdatedItem(item, name, url: UrlModel(url: event.url));
  }

  ItemModel _getUpdatedItem(ItemModel item, String? name,
      {UrlModel? url,
      SmsModel? sms,
      PhoneModel? phone,
      EmailModel? email,
      WifiModel? wifi}) {
    return item.copyWith(
        name: name, url: url, sms: sms, phone: phone, email: email, wifi: wifi);
  }

  //#endregion

  void loadingItemFromOtherPageEvent(ItemModel item) {
    emit(state.copyWith(
        item: item, selectedCategoryId: item.category!.id));
  }
}
