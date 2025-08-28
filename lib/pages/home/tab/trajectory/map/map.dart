import 'dart:async';
import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/device.dart';
import 'package:battery/common/models/api/res_locationAreaList_entity.dart';
import 'package:battery/common/models/api/res_trajectoryInfo_entity.dart';
import 'package:battery/common/utils/map_query.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMapPage extends StatelessWidget {
  /// 判断是照亮还是路径 1为照亮 0为路径
  final bool type;
  final String? groupId;
  const ShowMapPage({super.key, required this.type, this.groupId});

  @override
  Widget build(BuildContext context) {
    return MapSample(
      type: type,
      groupId: groupId,
    );
    // return const SizedBox();
  }
}

class MapSample extends StatefulWidget {
  final bool type; // 在这里声明一个字段
  final String? groupId;
  const MapSample({super.key, required this.type, this.groupId});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> with TickerProviderStateMixin {
  final Completer<GoogleMapController> _controllerGoogleMapController =
      Completer<GoogleMapController>();
  final Set<Polygon> _polygons = <Polygon>{};
  Set<Polygon> polygons = {};
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  late AnimationController _controller;
  late Animation<double> _animation;
  int currentPointIndex = 1;
  GoogleMapController? googleMapController;
  LatLng target = const LatLng(15.0702, 105.4925);
  // LatLng target = const LatLng(22.596614, 113.8700218);
  Future<void> dataJson() async {
    final data = OfflineGeoLocator();

    await data.loadGeoJson();

    List<String> dataName = [];
    ResLocationAreaListEntity? dataNames = await DeviceApis.locationAreaList();
    if (dataNames != null) {
      for (ResLocationAreaListList element in dataNames.list ?? []) {
        dataName.add(element.areaName ?? '');
      }
    }
    final dataPolygons = data.parseGeoJsonToPolygons(dataName);
    setState(() {
      _polygons.addAll(dataPolygons);
    });
  }

  @override
  void initState() {
    if (widget.type) {
      dataJson();
    } else {
      drawLine();
    }

    super.initState();
  }

  /// 画线并添加动画
  Future<void> drawLine() async {
    Set<Marker> tempMarkers = {}; // 临时存储标记数据
    Set<Polyline> tempPolylines = {}; // 临时存储路径数据
    List<LatLng> points = [];
    final itemData =
        await DeviceApis.trajectoryInfo(groupId: widget.groupId ?? '');
    if (itemData != null && itemData.list != null) {
      for (ResTrajectoryInfoList element in itemData.list ?? []) {
        points.add(LatLng(double.parse(element.latitude ?? ""),
            double.parse(element.longitude ?? "")));
      }
      if (points.isNotEmpty) {
        target = points.first;
        googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(target.latitude, target.longitude),
          18,
        ));
      }
      // 画起点标记
      tempMarkers.add(Marker(
        position: points.first, // 起点位置
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(100, 70)),
            'assets/images/3.0x/start.png'), // 起点图标
        infoWindow: const InfoWindow(title: 'Start'),
        markerId: const MarkerId("value1"),
      ));

      // 画终点标记
      tempMarkers.add(Marker(
        markerId: const MarkerId("value"),
        position: points.last, // 终点位置
        anchor: const Offset(0.07, 1),
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(100, 70)),
            'assets/images/3.0x/end.png'), // 终点图标
        infoWindow: const InfoWindow(title: 'End'),
      ));

      // 启动动画并逐步绘制路径
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1), // 动画持续时间
      );

      _animation = Tween<double>(begin: 0, end: points.length.toDouble())
          .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

      _animation.addListener(() {
        setState(() {
          currentPointIndex = _animation.value.toInt();
          if (currentPointIndex >= 2 && currentPointIndex <= points.length) {
            polylines = {
              Polyline(
                points: points.sublist(0, currentPointIndex),
                color: const Color.fromARGB(255, 250, 105, 61),
                polylineId: const PolylineId("values"),
                jointType: JointType.round,
                endCap: Cap.roundCap,
                startCap: Cap.roundCap,
              )
            };
          }
        });
      });

      // 开始动画
      _controller.forward();

      // 更新状态
      setState(() {
        markers = tempMarkers;
        polylines = tempPolylines;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition kGooglePlex = CameraPosition(
      target: target,
      bearing: -10,
      zoom: widget.type ? 5.8 : 18,
      // zoom: widget.type ? 20 : 18,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        compassEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false, // 显示定位按钮
        myLocationEnabled: false, // 显示当前位置蓝点

        polygons: _polygons,
        polylines: polylines,
        markers: markers,
        mapType: MapType.hybrid,
        initialCameraPosition: kGooglePlex,
        onMapCreated: (GoogleMapController controller) async {
          _controllerGoogleMapController.complete(controller);
          googleMapController = controller;
          // // 获取当前位置
          // Position position = await Geolocator.getCurrentPosition(
          //     locationSettings: AndroidSettings(
          //   accuracy: LocationAccuracy.best,
          //   distanceFilter: 0,
          // ));
          // double gcjLat = position.latitude;
          // double gcjLon = position.longitude;

          // final wgs84 = CoordinateConverter.wgs84ToGcj02(gcjLat, gcjLon);
          // setState(() {
          //   markers = {
          //     Marker(
          //       markerId: const MarkerId('current'),
          //       position: LatLng(wgs84['lat'] ?? 0, wgs84['lon'] ?? 0),
          //       infoWindow: const InfoWindow(title: '当前位置'),
          //     )
          //   };
          // });
          // // 动画移动到当前位置
        },
      ),
    );
  }
}
