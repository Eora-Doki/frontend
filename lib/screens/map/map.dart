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
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _loadHtml();
  }

  Future<void> _loadHtml() async {
    final htmlMap = await rootBundle.loadString('assets/kakao_map.html');
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'ready',
        onMessageReceived: (message) async {
          final position = await LocationService.getCurrentLocation();
          if (position != null) {
            final latitude = position['latitude'];
            final longitude = position['longitude'];

            await _controller.runJavaScript("updateLocation($latitude, $longitude);");

            final stores = await ApiService.getNearbyStores(
              latitude: latitude,
              longitude: longitude,
            );

            for (final store in stores) {
              final storeLat = store['latitude'];
              final storeLng = store['longitude'];
              await _controller.runJavaScript("addMarker($storeLat, $storeLng);");
            }
          }
        },
      )
      ..setNavigationDelegate(NavigationDelegate(
        onWebResourceError: (error) {
          print("WebView error: ${error.description}");
        },
        onPageFinished: (url) {
          print("Page finished loading: $url");
        },
      ))
      ..loadHtmlString(htmlMap);

    setState(() {}); // 웹뷰 리빌드
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
