import '../../data/services/i_services/i_home_service.dart';
import '../../models/models.dart';
import '../base_bloc.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  final IHomeService _service;

  HomeBloc(this._service)
      : super(const HomeState(
            itemList: [], selectedIndexList: [], isSelectAll: false));

  // Stream<int> get countStream =>
  //     stateStream.map((state) => state.count!).distinct();
  Stream<List<ItemModel>> get itemsStream =>
      stateStream.map((state) => state.itemList!).distinct();

  // void incrementCount() async{
  //   load(true);
  //   await Future.delayed(const Duration(seconds: 5));
  //   load(false);
  //   emit(state.copyWith(count: state.count! + 1));
  // }
  //
  // void decrementCount(){
  //   emit(state.copyWith(count: state.count! - 1));
  // }

  void reloadAllItem() async {
    load(true);
    // call items from db
    List<ItemModel> items = await _service.getAllItem();
    emit.call(state.copyWith(itemList: items));
    load(false);
  }
}
