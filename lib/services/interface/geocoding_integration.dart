import '../data_class/geo_info.dart';

abstract class GeocodingIntegration {
  Future<GeoInfo> getGeoByPlace(
      {String? street,
      String? city,
      String? county,
      String? state,
      String? country,
      String? postalCode});

  Future<GeoInfo> getGeoByQuery(String query);

  Future<GeoInfo> getGeoByLocation(double latitude, double longitude);
}
