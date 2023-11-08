import '../repositories/i_app_repository.dart';
import 'i_services/i_splash_service.dart';

class SplashService implements ISplashService {
  final IAppRepository _appRepository;

  SplashService(this._appRepository);

  @override
  Future<bool> initData() async {
    try {
      return await _appRepository.initData();
    } catch (e) {
      throw Exception(e);
    }
  }
}