// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

// class RiskAreaMap extends StatefulWidget {
//   final double lat;
//   final double long;
//   const RiskAreaMap({super.key, required this.lat, required this.long});

//   @override
//   State<RiskAreaMap> createState() => _RiskAreaMapState();
// }

// class _RiskAreaMapState extends State<RiskAreaMap> {
//   // default constructor
//   late MapController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = MapController.withPosition(
//       initPosition: GeoPoint(
//         latitude: widget.lat,
//         longitude: widget.long,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           color: Colors.blueGrey, // Adjust the color to match your design
//           borderRadius: BorderRadius.circular(12),
//         ),
//         width: double.infinity,
//         height: 300, // Set the height to 150
//         margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
//         child: OSMFlutter(
//             controller: controller,
//             osmOption: OSMOption(
//                 zoomOption: const ZoomOption(
//                   initZoom: 16,
//                   minZoomLevel: 3,
//                   maxZoomLevel: 19,
//                   stepZoom: 1.0,
//                 ),
//                 markerOption: MarkerOption(
//                     defaultMarker: MarkerIcon(
//                   iconWidget: const Icon(
//                     Icons.person_pin_circle,
//                     color: Colors.blue,
//                     size: 56,
//                   ),
//                 )))));
//   }
// }
