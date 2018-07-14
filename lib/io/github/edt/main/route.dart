import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:watering_map/io/github/edt/main/lazy_load.dart';
import 'package:watering_map/io/github/edt/main/main.dart';
import 'package:watering_map/io/github/edt/main/strings.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class Route {

  final MarkerLayerOptions roadSet = MarkerLayerOptions(markers: []),
      resSet = MarkerLayerOptions(markers: []),
      parkSet = MarkerLayerOptions(markers: []);

  bool _loaded = false;
  List<Tree> trees;

  Route({this.trees}) {
    handleTrees().then((_) => _loaded = true);
  }

  Future<Null> handleTrees() async {
    int num = trees.length;
    int done = 0;
    for (Tree t in trees) {
      t.loadLocation().then((_) {
        done++;
        switch (t.type) {
          case TreeType.ROAD:
            roadSet.markers.add(t.marker);
            break;
          case TreeType.RES:
            resSet.markers.add(t.marker);
            break;
          case TreeType.PARK:
            parkSet.markers.add(t.marker);
            break;
        }
        if (done >= num) {
          _loaded = true;
        }
      });
    }
  }

  void bind(FlutterMap map) {
    if (!_loaded) return;

    map.layers.removeWhere((opts) => opts is MarkerLayerOptions);
    map.layers.add(roadSet);
    map.layers.add(resSet);
    map.layers.add(parkSet);
  }
}

class Tree {
//  final Marker marker;
  final TreeType type;
  Route _route;
  bool isLoaded = false;

  Tree({
    @required this.FACILITYID,
    @required this.type,
  }) {
//    if (loadProperties) loadProperties();
  }

  final int FACILITYID; // required

  Map<String, LazyLoadedParameter> _properties = {
    // MISSING: SHAPE
    "OBJECTID": LazyLoadedParameter<int>(),
    "PARK": LazyLoadedParameter<String>(),
    "TREE": LazyLoadedParameter<double>(),
    "DESCRIPTION": LazyLoadedParameter<String>(),
    "LOCATION": LazyLoadedParameter<String>(),
    "TREE_GENUS": LazyLoadedParameter<String>(),
    "TREE_SPECIES": LazyLoadedParameter<String>(),
    "TREE_VARIETY": LazyLoadedParameter<String>(),
    "TREE_TYPE": LazyLoadedParameter<String>(),
    "ROAD_TYPE": LazyLoadedParameter<String>(),
    "GROW_SPACE_LOCATION": LazyLoadedParameter<String>(),
    "PLANTED_BY": LazyLoadedParameter<String>(),
    "TREE_WATERING": LazyLoadedParameter<String>(),
    "TREE_WELL": LazyLoadedParameter<String>(),
    "TREE_WELL_TYPE": LazyLoadedParameter<String>(),
    "HERITAGE_SIGNIFICANT_TREE": LazyLoadedParameter<String>(),
    "GIFT_DONATION": LazyLoadedParameter<String>(),
    "IRRIGATION_AT_BASE": LazyLoadedParameter<String>(),
    "TREE_ELECTRICAL_SYSTEM": LazyLoadedParameter<String>(),
    "TREE_STAKE": LazyLoadedParameter<String>(),
    "TREE_GRATE": LazyLoadedParameter<String>(),
    "TREE_GAURD": LazyLoadedParameter<String>(),
    "TREE_CABLE_AND_BRACE": LazyLoadedParameter<String>(),
    "CABLES": LazyLoadedParameter<double>(),
    "BRACES": LazyLoadedParameter<double>(),
    "OVERHEAD_UTILITY_LINES": LazyLoadedParameter<String>(),
    "HEIGHT_M": LazyLoadedParameter<double>(),
    "TREE_SIZE_CLASSIFICATION": LazyLoadedParameter<String>(),
    "TREE_DIAMETER_CM": LazyLoadedParameter<double>(),
    "ROOT_GROWTH_IMPERVIOUS_PERCENT": LazyLoadedParameter<double>(),
    "TOOR_GROWTH_SPACE_RESTR": LazyLoadedParameter<String>(),
    "TRUNK_FLAIR_GROWTH_SPACE_M2": LazyLoadedParameter<double>(),
    "CANOPY_GROWTH_SPACE": LazyLoadedParameter<String>(),
    "CANOPY_GROWTH_SPACE_RESTR": LazyLoadedParameter<String>(),
    "SOIL_QUALITY": LazyLoadedParameter<String>(),
    "STRUCTURED_SOIL_TYPE": LazyLoadedParameter<String>(),
    "YEAR_REMOVED": LazyLoadedParameter<double>(),
    "CAUSE_OF_REMOVAL": LazyLoadedParameter<String>(),
    "SERVICE_LEVEL": LazyLoadedParameter<String>(),
    "COMMENTS": LazyLoadedParameter<String>(),
    "HOUSE_NO": LazyLoadedParameter<String>(),
    "ROAD_CODE": LazyLoadedParameter<String>(),
    "MAP_PAGE": LazyLoadedParameter<String>(),
    "STATUS": LazyLoadedParameter<String>(),
    "STATUS_DATE": LazyLoadedParameter<String>(),
    "PARK_OWNERSHIP": LazyLoadedParameter<String>(),
    "MAINTENANCE_RESPONSIBILITY": LazyLoadedParameter<String>(),
    "OPERATIONAL_RESPONSIBILITY": LazyLoadedParameter<String>(),
    "WORK_ASSIGNMENT": LazyLoadedParameter<String>(),
    "INSERVICE_DATE": LazyLoadedParameter<int>(), // is date
    "INSERVICE_COST": LazyLoadedParameter<double>(),
    "CONDITION": LazyLoadedParameter<String>(),
    "CONDITIONDATE": LazyLoadedParameter<String>(),
    "YRS_LIFE_EXPECTANCY": LazyLoadedParameter<int>(),
    "WARRANTYDATE": LazyLoadedParameter<int>(), // is date
    "WARRANTY_PROVIDER": LazyLoadedParameter<String>(),
    "VENDOR": LazyLoadedParameter<String>(),
    "MAKE": LazyLoadedParameter<String>(),
    "MODEL": LazyLoadedParameter<String>(),
    "SERIAL_NO": LazyLoadedParameter<String>(),
    "BARCODE": LazyLoadedParameter<String>(),
    "LEGACYID": LazyLoadedParameter<String>(),
    "OPERATING_LOCATION": LazyLoadedParameter<String>(),
    "OPERATING_LOCATION_TYPE": LazyLoadedParameter<String>(),
    "INSPECTION": LazyLoadedParameter<String>(),
  };

  LazyLoadedParameter<LatLng> _loc = LazyLoadedParameter<LatLng>();
  Marker marker;

  get loc => this._loc.content;

  LazyLoadedParameter getProperty(String key) => _properties[key];

  Future<Null> loadProperties() async {
    // TODO: do loading from Surrey tree api with params
    String url =
        "http://cosmos.surrey.ca/cosrest/rest/services/OpenData/MapServer/239/query?where=FACILITYID%3D%27$FACILITYID%27&returnIdsOnly=false&returnGeometry=true&f=geojson";
    http.get(url).then((response) {
      print(response);
    });
  }

  Future<Null> loadLocation() async {
    String url =
        "http://cosmos.surrey.ca/cosrest/rest/services/OpenData/MapServer/239/query?where=FACILITYID+%3D+%27$FACILITYID%27&text=&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&relationParam=&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&resultOffset=&resultRecordCount=&f=geojson";
    await http.get(url).then((final response) {
      try {
        Map json = JSON.jsonDecode(response.body);
        var coords = json["features"][0]["geometry"]["coordinates"];
        double lng = coords[0];
        double lat = coords[1];
        _loc.update(LatLng(lat, lng));
        print(_loc.content);
      } catch (error) {
        print(response.body);
        print(FACILITYID);
        print(error);
      }
      loadMarker();
      isLoaded = true;
    });
  }

  void loadMarker() {
    print("load");
    print(this.loc);

    var color;

    switch (type) {
      case TreeType.ROAD:
      case TreeType.PARK:
        color = const Color(0xff4286f4);
        break;
      case TreeType.RES:
        color = const Color(0xfff44141);
        break;
    }

    marker = new Marker(
      point: this.loc,
      builder: (_) => new Icon(Icons.brightness_1, size: 6.0, color: color),
      width: 10.0,
      height: 10.0,
    );
  }
}

/// Enum with fields
class TreeType {
  final String _value;
  final ImageIcon _icon;

  static const ICON_SIZE = 16;

  const TreeType._internal(this._value, this._icon);

  toString() => 'Enum.$_value';

  getIcon() => _icon;

  static const ROAD =
      const TreeType._internal('ROAD', ImageIcon(AssetImage(ROAD_IMAGE_LOC)));
  static const RES =
      const TreeType._internal('RES', ImageIcon(AssetImage(RES_IMAGE_LOC)));
  static const PARK =
      const TreeType._internal('PARK', ImageIcon(AssetImage(PARK_IMAGE_LOC)));
}
