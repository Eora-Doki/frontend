import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../services/api_service.dart';
import '../../services/location_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _loadHtml();
  }

  Future<void> _loadHtml() async {
    final htmlMap = await rootBundle.loadString('assets/kakao_map.html');

    final controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
          onPageFinished: (url) async {
            final position = await LocationService.getCurrentLocation();
            if (position != null) {
              final lat = position['latitude'];
              final lng = position['longitude'];
              print("현재 위치: $lat, $lng");

              await controller.runJavaScript("initMap($lat, $lng);");

              final stores = await ApiService.getNearbyStores(lat: lat, lng: lng);
              final jsonString = jsonEncode(stores).replaceAll("'", r"\'");
              await controller.runJavaScript("addStoreMarkers('$jsonString');");

              print("지도 및 마커 로딩 완료");
            } else {
              print("위치 정보 가져오기 실패");
            }
          }
      ))
      ..loadHtmlString(htmlMap);

    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller == null
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: _controller!),
    );
  }
}
