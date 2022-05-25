import 'package:coin_sim/ui/home/model/assets_model.dart';
import 'package:coin_sim/ui/home/service/home_page_service.dart';
import 'package:mobx/mobx.dart';
part 'home_page_viewmodel.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store {
  @observable
  AssetsModel? assetsModel;
  @observable
  List<AssetsModel?>? assetsModelList = [];

  @action
  getAssets() async {
    var json = await HomePageService().getAssets();
    if (json != null)
      json.forEach((element) {
        assetsModel = AssetsModel.fromJson(element);
        assetsModelList!.add(assetsModel);
      });
    ;
  }
}
