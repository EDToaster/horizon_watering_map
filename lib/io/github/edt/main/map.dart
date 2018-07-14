import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:watering_map/io/github/edt/main/drive_loader.dart';
import 'package:watering_map/io/github/edt/main/strings.dart';
import 'package:watering_map/io/github/edt/restricted/restricted_resources.dart';
import 'package:location/location.dart';
import 'main.dart';
import 'route.dart' as route;

Location loc = new Location();

class MapPage extends StatelessWidget {
  static route.Route exampleRoute = new route.Route(trees: [
    new route.Tree(FACILITYID: 1001863321, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001824893, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001824895, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001825318, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001927199, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1002042932, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001825043, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001545018, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001550050, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001550051, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001550053, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001550054, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001824897, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001824898, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001996744, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001703782, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001703783, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001703784, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001703785, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001703837, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704304, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704345, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704346, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704347, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704455, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704456, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704457, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704458, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704459, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704461, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704462, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704463, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704464, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704504, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704505, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704506, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704612, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704613, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704614, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704615, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704616, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704617, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001704618, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001990341, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001602184, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001743613, type: route.TreeType.RES),
    new route.Tree(FACILITYID: 1001731897, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001704886, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001704290, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001749821, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001749822, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001749825, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001990340, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001738061, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001738062, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001738063, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001702581, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001702582, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001933046, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001933047, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001933048, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001731891, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001861285, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001861286, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001861291, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001861292, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001861293, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001861294, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001861295, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001861381, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001861382, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001864805, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001864806, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001864808, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001809107, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001809108, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001809109, type: route.TreeType.ROAD),
    new route.Tree(FACILITYID: 1001809110, type: route.TreeType.ROAD),
  ]);
  static MapController controller = new MapController();
  FlutterMap map = FlutterMap(
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
      new MarkerLayerOptions(markers: [
        Marker(
          point: new LatLng(49.0398340, -122.8393690),
          builder: (_) =>
              new Icon(Icons.add_box, size: 10.0, color: themeColor),
        ),
      ]),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cosmos v2"),
      ),
      /** Settings Drawer**/
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            child: new Text('Settings'),
            decoration: BoxDecoration(color: themeColor),
          ),
          new ListTile(
            title: new Row(
              children: [
                new Icon(
                  Icons.account_box,
                  color: themeColor,
                ),
                new Text(AUTH),
              ],
            ),
            subtitle: new Text(AUTH_SUB),
            onTap: authenticateSession,
          ),
          new ListTile(
            title: new Row(
              children: [
                new Icon(
                  Icons.exit_to_app,
                  color: themeColor,
                ),
                new Text(DEAUTH),
              ],
            ),
            onTap: deauthenticateSession,
          ),
          new ListTile(
            title: new Row(children: [
              new Icon(
                Icons.file_download,
                color: themeColor,
              ),
              new Text(LOAD_ROUTE),
            ]),
            subtitle: new Text(LOAD_ROUTE_SUB),
            onTap: () {
              exampleRoute.bind(map);
              controller.move(controller.center, controller.zoom); // simulate update
            },
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
        child: map,
      ),
    );
  }
}
