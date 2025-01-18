import 'package:cuaca_klimata/services/interface/geocoding_integration.dart';
import 'package:flutter/widgets.dart';

import '../data_class/geo_info.dart';

class SearchGeoNotifier extends ChangeNotifier{
  List<GeoInfo>? suggestion;
  final GeocodingIntegration? geocodingIntegration;

  bool loading;

  SearchGeoNotifier(this.geocodingIntegration) : loading = false;

  Future<void> searchGeo(String query) async{
    GeocodingIntegration? gi = geocodingIntegration;
    if (gi != null && !loading) {
      loading = true;
      notifyListeners();

      suggestion = await geocodingIntegration?.searchGeo(query);

      loading = false;
      notifyListeners();
    }
  }
}