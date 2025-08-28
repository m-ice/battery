import 'dart:convert';
import 'package:battery/app_library.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OfflineGeoLocator {
  List<Map<String, dynamic>> provinces = [];

  /// 加载 GeoJSON 文件
  Future<void> loadGeoJson() async {
    String data = await rootBundle.loadString('assets/json/map.json');
    provinces = List<Map<String, dynamic>>.from(jsonDecode(data)["features"]);
  }

  String normalizeRegionName(String name) {
    return name.toLowerCase().replaceAll(RegExp(r'[\s\-]'), '');
  }

  /// 根据名称列表，解析成 Google Map 的 Polygon
  List<Polygon> parseGeoJsonToPolygons(List<String> regionNames) {
    List<Polygon> polygons = [];

    // 将 regionNames 也标准化成一个 Set
    final normalizedTargetNames =
        regionNames.map((e) => normalizeRegionName(e)).toSet();

    for (var feature in provinces) {
      var name = feature['properties']['NAME_1'];
      if (name == null) continue;

      // 标准化当前省份名
      var normalizedGeoName = normalizeRegionName(name);

      // 匹配成功才处理
      if (!normalizedTargetNames.contains(normalizedGeoName)) continue;

      var geometry = feature['geometry'];
      var geometryType = geometry['type'];
      var coordinates = geometry['coordinates'];

      if (geometryType == 'Polygon') {
        coordinates = [coordinates]; // 转成 MultiPolygon 结构
      }

      for (var polygonCoordinates in coordinates) {
        List<List<LatLng>> points = [];

        for (var ring in polygonCoordinates) {
          List<LatLng> datas = [];
          for (var coord in ring) {
            if (coord is List && coord.length == 2) {
              datas.add(
                  LatLng(coord[1].toDouble(), coord[0].toDouble())); // lat, lng
            }
          }
          points.add(datas);
        }

        for (var element in points) {
          polygons.add(Polygon(
            polygonId: PolygonId('polygon_${polygons.length}'),
            points: element,
            strokeWidth: 2,
            strokeColor: const Color(0xff31D2E2),
            fillColor:
                const Color(0xff31D2E2).withAlpha(51), // alpha: 0.2 * 255 ≈ 51
          ));
        }
      }
    }

    return polygons;
  }

  // Future<Position> getCurrentLocation() async {
  //   // 确保权限
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     throw Exception("Location services are disabled.");
  //   }

  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       throw Exception("Location permissions are denied");
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     throw Exception("Location permissions are permanently denied");
  //   }

  //   return await Geolocator.getCurrentPosition(
  //     locationSettings: AndroidSettings(
  //         accuracy: LocationAccuracy.bestForNavigation,
  //         distanceFilter: 0,
  //         forceLocationManager: true,
  //         foregroundNotificationConfig: const ForegroundNotificationConfig(
  //           notificationTitle: "正在定位",
  //           notificationText: "应用正在使用您的位置",
  //           enableWakeLock: true,
  //         )),
  //   );
  // }
}
