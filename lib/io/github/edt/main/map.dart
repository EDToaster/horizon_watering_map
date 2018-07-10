import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:watering_map/io/github/edt/main/drive_loader.dart';
import 'package:watering_map/io/github/edt/restricted/restricted_resources.dart';
import 'package:location/location.dart';
import 'main.dart';
import 'route.dart' as route;

Location loc = new Location();

class MapPage extends StatelessWidget {
  FlutterMap map;
  MapController controller = new MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cosmos v2"),
      ),
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            child: new Text('Settings'),
            decoration: BoxDecoration(color: themeColor),
          ),
          new ListTile(
            title: new Text('Auth'),
            onTap: authenticateSession,
          ),
          new ListTile(
            title: new Text('Deauth'),
            onTap: deauthenticateSession,
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loc.getLocation.then((currentLocation) {
            double lat = currentLocation['latitude'];
            double lng = currentLocation['longitude'];
            controller.move(new LatLng(lat, lng), 16.0);
          });
        },
        child: Icon(Icons.my_location),
      ),
      body: Center(
        child: map = FlutterMap(
          mapController: controller,
          options: new MapOptions(
            center: new LatLng(49.111, -122.768),
            zoom: 11.0,
            maxZoom: 16.9,
            minZoom: 11.0,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/edtoaster/cjj3jjmah1k5l2sn2lmo084ak/tiles/512/{z}/{x}/{y}?access_token={accessToken}",
              additionalOptions: {
                'accessToken': API_KEY,
              },
            ),
          ],
        ),
      ),
    );
  }
}
