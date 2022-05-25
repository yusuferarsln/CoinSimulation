///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class AssetsModel {
/*
{
  "id": "bitcoin",
  "rank": "1",
  "symbol": "BTC",
  "name": "Bitcoin",
  "supply": "19010831.0000000000000000",
  "maxSupply": "21000000.0000000000000000",
  "marketCapUsd": "784622169229.7041705867456269",
  "volumeUsd24Hr": "12046736001.4983375093251260",
  "priceUsd": "41272.3762169946264099",
  "changePercent24Hr": "3.8548561679391638",
  "vwap24Hr": "40611.3908027004470135",
  "explorer": "https://blockchain.info/"
} 
*/

  String? id;
  String? rank;
  String? symbol;
  String? name;
  String? supply;
  String? maxSupply;
  String? marketCapUsd;
  String? volumeUsd24Hr;
  String? priceUsd;
  String? changePercent24Hr;
  String? vwap24Hr;
  String? explorer;

  AssetsModel({
    this.id,
    this.rank,
    this.symbol,
    this.name,
    this.supply,
    this.maxSupply,
    this.marketCapUsd,
    this.volumeUsd24Hr,
    this.priceUsd,
    this.changePercent24Hr,
    this.vwap24Hr,
    this.explorer,
  });
  AssetsModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    rank = json['rank']?.toString();
    symbol = json['symbol']?.toString();
    name = json['name']?.toString();
    supply = json['supply']?.toString();
    maxSupply = json['maxSupply']?.toString();
    marketCapUsd = json['marketCapUsd']?.toString();
    volumeUsd24Hr = json['volumeUsd24Hr']?.toString();
    priceUsd = json['priceUsd']?.toString();
    changePercent24Hr = json['changePercent24Hr']?.toString();
    vwap24Hr = json['vwap24Hr']?.toString();
    explorer = json['explorer']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['rank'] = rank;
    data['symbol'] = symbol;
    data['name'] = name;
    data['supply'] = supply;
    data['maxSupply'] = maxSupply;
    data['marketCapUsd'] = marketCapUsd;
    data['volumeUsd24Hr'] = volumeUsd24Hr;
    data['priceUsd'] = priceUsd;
    data['changePercent24Hr'] = changePercent24Hr;
    data['vwap24Hr'] = vwap24Hr;
    data['explorer'] = explorer;
    return data;
  }
}