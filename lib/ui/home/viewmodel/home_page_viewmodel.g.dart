// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageViewModel on _HomePageViewModelBase, Store {
  final _$assetsModelAtom = Atom(name: '_HomePageViewModelBase.assetsModel');

  @override
  AssetsModel? get assetsModel {
    _$assetsModelAtom.reportRead();
    return super.assetsModel;
  }

  @override
  set assetsModel(AssetsModel? value) {
    _$assetsModelAtom.reportWrite(value, super.assetsModel, () {
      super.assetsModel = value;
    });
  }

  final _$assetsModelListAtom =
      Atom(name: '_HomePageViewModelBase.assetsModelList');

  @override
  List<AssetsModel?>? get assetsModelList {
    _$assetsModelListAtom.reportRead();
    return super.assetsModelList;
  }

  @override
  set assetsModelList(List<AssetsModel?>? value) {
    _$assetsModelListAtom.reportWrite(value, super.assetsModelList, () {
      super.assetsModelList = value;
    });
  }

  final _$getAssetsAsyncAction =
      AsyncAction('_HomePageViewModelBase.getAssets');

  @override
  Future getAssets() {
    return _$getAssetsAsyncAction.run(() => super.getAssets());
  }

  @override
  String toString() {
    return '''
assetsModel: ${assetsModel},
assetsModelList: ${assetsModelList}
    ''';
  }
}
