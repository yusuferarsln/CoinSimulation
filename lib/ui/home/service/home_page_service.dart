import 'package:coin_sim/core/network_manager.dart';

class HomePageService {
  getAssets() async {
    try {
      var response =
          await NetworkManager.instance!.dio.get('assets');
      var body;
      if (response.data['data'] != null) {
        body = response.data['data'];
        return body;
      }
      return body;
    } catch (e) {
      print(e);
    }
  }
}
