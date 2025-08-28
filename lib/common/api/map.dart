import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

List<List<LatLng>> parsePolyline(String polylineData) {
  // 按竖线（|）分割字符串，获取每个区域
  List<List<LatLng>> latLngList = [];

  int start = 0; // 跟踪当前区域的开始位置
  for (int i = 0; i <= polylineData.length; i++) {
    if (i == polylineData.length || polylineData[i] == '|') {
      // 分割出每个区域的坐标数据
      String areaData = polylineData.substring(start, i);
      List<LatLng> regionLatLngList = _parseAreaData(areaData);
      if (regionLatLngList.isNotEmpty) {
        latLngList.add(regionLatLngList);
      }
      start = i + 1; // 更新开始位置
    }
  }

  return latLngList;
}

List<LatLng> _parseAreaData(String areaData) {
  List<LatLng> regionLatLngList = [];
  int start = 0; // 跟踪坐标对的开始位置
  for (int i = 0; i <= areaData.length; i++) {
    if (i == areaData.length || areaData[i] == ';') {
      // 获取坐标对并解析
      String coordinate = areaData.substring(start, i);
      regionLatLngList.add(_parseCoordinate(coordinate));
      start = i + 1; // 更新开始位置
    }
  }
  return regionLatLngList;
}

LatLng _parseCoordinate(String coordinate) {
  int commaIndex = coordinate.indexOf(',');
  if (commaIndex == -1) {
    return const LatLng(0, 0); // 如果格式不对，返回一个默认值
  }

  // 分割经纬度并解析
  double lng = double.parse(coordinate.substring(0, commaIndex));
  double lat = double.parse(coordinate.substring(commaIndex + 1));

  return LatLng(lat, lng);
}

Future<Map<String, String>?> getProvinceAndAddressFromCoordinates(
    double lat, double lng) async {
  const String apiKey = "AIzaSyA-dChIKd4MpJcuWLLafezPnK4zyJvdz40";
  final String url =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data['status'] == 'OK') {
      String? province;
      String? fullAddress = data['results'][2]['formatted_address'];

      // // 去掉 Plus Code 前缀，例如 "HVW9+HV9, "
      // if (fullAddress != null &&
      //     RegExp(r'^[A-Z0-9]+\+[A-Z0-9]+, ').hasMatch(fullAddress)) {
      //   fullAddress =
      //       fullAddress.replaceFirst(RegExp(r'^[A-Z0-9]+\+[A-Z0-9]+, '), '');
      // }

      for (var result in data['results']) {
        for (var component in result['address_components']) {
          if (component['types'].contains('administrative_area_level_1')) {
            province = component['long_name']; // 获取省名
            break;
          }
        }
        if (province != null) break;
      }

      return {
        'province': province ?? '',
        'address': fullAddress ?? '',
      };
    }
  }
  return null;
}
