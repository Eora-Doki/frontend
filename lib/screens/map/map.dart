import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
          print("✅ Page finished loading");

          final position = await LocationService.getCurrentLocation();
          if (position != null) {
            final lat = position['latitude'];
            final lng = position['longitude'];

            try {
              print("📍 위치: $lat, $lng");
              await controller.runJavaScript("updateLocation($lat, $lng);");
              print("✅ 지도 초기화 완료");
            } catch (e) {
              print("❌ JS 호출 실패: $e");
            }
          } else {
            print("❌ 현재 위치 가져오기 실패");
          }
        },
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
