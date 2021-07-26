import 'package:covid_simple_tracker/models/covid.dart';
import 'package:covid_simple_tracker/services/api_country_service.dart';




class CovidCountry extends Covid {
  @override
  String? name;

  CovidCountry(this.name);

  String? get getName {
    return name;
  }

  ///[getFetchConfirmed] getting fetch of confirmed count from specific country from the API service to get data
  @override
  Future<void> getFetchConfirmed() async {
    var service = APICovidService(countryName: name!);
    Map<String, dynamic> data = await service.getCountryDetail();
    super.confirmed = data['deaths']['value'];
  }

  ///[getFetchCured] getting fetch cured count from specific country from the API service to get data
  @override
  Future<void> getFetchCured() async {
    var service = APICovidService(countryName: name!);
    Map<String, dynamic> data = await service.getCountryDetail();
    super.cured = data['recovered']['value'];
  }

  ///[getFetchDeath] getting fetch death count from specific country from the API service to get data
  @override
  Future<void> getFetchDeath() async {
    var service = APICovidService(countryName: name!);
    Map<String, dynamic> data = await service.getCountryDetail();
    super.death = data['confirmed']['value'];
  }

  ///[getLastUpdate] getting fetch last update summary from specific country from the API service to get data
  @override
  Future<void> getLastUpdate() async {
    var service = APICovidService(countryName: name!);
    String lastUpdate = await service.getLastUpdate();
    super.lastUpdate = lastUpdate;
  }
}

