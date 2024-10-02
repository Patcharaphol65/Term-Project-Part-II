// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class RiskAreaGoogleMap extends StatefulWidget {
//   final double lat;
//   final double long;
//   const RiskAreaGoogleMap({super.key, required this.lat, required this.long});

//   @override
//   State<RiskAreaGoogleMap> createState() => _RiskAreaGoogleMapState();
// }

// class _RiskAreaGoogleMapState extends State<RiskAreaGoogleMap> {
//   late GoogleMapController mapController;

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.blueGrey, // Adjust the color to match your design
//         borderRadius: BorderRadius.circular(12),
//       ),
//       width: double.infinity,
//       height: 300, // Set the height to 150
//       margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
//       child: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(widget.lat, widget.long), // Use the passed lat/long
//           zoom: 11.0,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('location'),
//             position: LatLng(widget.lat, widget.long), // Use the passed lat/long
//           ),
//         },
//       ),
//     );
//   }
// }
