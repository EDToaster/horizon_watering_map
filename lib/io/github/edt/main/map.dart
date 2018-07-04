import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:watering_map/io/github/edt/restricted/restricted_resources.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(49.111, -122.768),
        zoom: 11.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/edtoaster/cjj3jjmah1k5l2sn2lmo084ak/tiles/512/{z}/{x}/{y}?access_token={accessToken}",
          additionalOptions: {
            'accessToken': API_KEY,
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 10.0,
              height: 10.0,
              point: new LatLng(49.039802, -122.839288),
              builder: (ctx) => new Container(
                    child: new FlutterLogo(),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
