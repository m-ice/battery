import 'dart:math';

class CoordinateConverter {
  static const double pi = 3.1415926535897932384626;
  static const double a = 6378245.0; // 长半轴
  static const double ee = 0.00669342162296594323; // 偏心率平方

  // WGS-84 转 GCJ-02
  static Map<String, double> wgs84ToGcj02(double lat, double lon) {
    if (outOfChina(lat, lon)) {
      return {'lat': lat, 'lon': lon};
    } else {
      double dLat = transformLat(lon - 105.0, lat - 35.0);
      double dLon = transformLon(lon - 105.0, lat - 35.0);
      double radLat = lat / 180.0 * pi;
      double magic = sin(radLat);
      magic = 1 - ee * magic * magic;
      double sqrtMagic = sqrt(magic);
      dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
      dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
      double mgLat = lat + dLat;
      double mgLon = lon + dLon;
      return {'lat': mgLat, 'lon': mgLon};
    }
  }

  static bool outOfChina(double lat, double lon) {
    return lon < 72.004 || lon > 137.8347 || lat < 0.8293 || lat > 55.8271;
  }

  static double transformLat(double x, double y) {
    double ret = -100.0 +
        2.0 * x +
        3.0 * y +
        0.2 * y * y +
        0.1 * x * y +
        0.2 * sqrt(x.abs());
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    ret +=
        (160.0 * sin(y / 12.0 * pi) + 320.0 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return ret;
  }

  static double transformLon(double x, double y) {
    double ret =
        300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(x.abs());
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    ret +=
        (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return ret;
  }
}
