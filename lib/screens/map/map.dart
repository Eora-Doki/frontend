import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onWebResourceError: (error) {
          print("WebView error: ${error.description}");
        },
        onPageFinished: (url) {
          print("Page finished loading: $url");
        },
      ))
      ..loadHtmlString('''
        <!DOCTYPE html>
        <html>
        <head>
          <meta charset="utf-8">
          <title>Kakao Map</title>
          <style>
            html, body { margin: 0; padding: 0; height: 100%; }
            #map { width: 100%; height: 100%; }
          </style>
        </head>
        <body>
          <div id="map"></div>

          <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function() {
              var script = document.createElement('script');
              script.onload = function() {
                kakao.maps.load(function() {
                  var mapContainer = document.getElementById('map');
                  var mapOption = {
                    center: new kakao.maps.LatLng(37.5665, 126.9780),
                    level: 3
                  };
                  var map = new kakao.maps.Map(mapContainer, mapOption);
                });
              };
              script.src = "https://dapi.kakao.com/v2/maps/sdk.js?appkey=d172d22c60e3873dff49ddbd4c0526fb&autoload=false";
              document.head.appendChild(script);
            });
          </script>
        </body>
        </html>
      ''');


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
