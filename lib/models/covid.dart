abstract class Covid {
  dynamic death;
  dynamic confirmed;
  dynamic cured;
  String? lastUpdate;
  String? name;

  Future<void> getFetchConfirmed();
  Future<void> getFetchDeath();
  Future<void> getFetchCured();
  Future<void> getLastUpdate();
}
