import 'package:covid_simple_tracker/models/additional_stats.dart';
import 'package:covid_simple_tracker/models/covid.dart';
import 'package:covid_simple_tracker/services/api_global_service.dart';


class CovidProvince extends Covid {
  @override
  String? name;
  int index;
  List provinces;

  CovidProvince(this.name, {required this.index, required this.provinces});

  @override
  Future<void> getFetchConfirmed() async {
    Map provinceData = await getProvinceDetail(provinces, index);
    super.confirmed = provinceData['confirmed'];
  }

  @override
  Future<void> getFetchCured() async {
    Map provinceData = await getProvinceDetail(provinces, index);
    super.cured = provinceData['recovered'];
  }

  @override
  Future<void> getFetchDeath() async {
    Map provinceData = await getProvinceDetail(provinces, index);
    super.death = provinceData['deaths'];
  }

  @override
  Future<void> getLastUpdate() async {
    var globalLastUpdate = CovidGlobalAPIService();
    super.lastUpdate = await globalLastUpdate.getLastUpdate();
  }
}
