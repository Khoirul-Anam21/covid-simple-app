import 'package:covid_simple_tracker/models/covid.dart';
import 'package:covid_simple_tracker/services/api_global_service.dart';

class GlobalCovid extends Covid {
  String name = 'global';
  CovidGlobalAPIService service = CovidGlobalAPIService();

   ///[getFetchConfirmed] getting fetch of confirmed count from global/all country from the API service to get data
  @override
  Future<void> getFetchConfirmed() async {
    Map<String, dynamic> data = await service.getGlobalData();
    super.confirmed = data['confirmed']['value'];
  }

  ///[getFetchCured] getting fetch of recovered count from global/all country from the API service to get data
  @override
  Future<void> getFetchCured() async {
    Map<String, dynamic> data = await service.getGlobalData();
    super.cured = data['recovered']['value'];
  }

  ///[getFetchDeath] getting fetch of deaths count from global/all country from the API service to get data
  @override
  Future<void> getFetchDeath() async {
    Map<String, dynamic> data = await service.getGlobalData();
    super.death = data['deaths']['value'];
  }

  ///[getLastUpdate] getting fetch of last update from global/all country from the API service to get data
  @override
  Future<void> getLastUpdate() async {
    String lastUpdateData = await service.getLastUpdate();
    super.lastUpdate = lastUpdateData;
  }
}