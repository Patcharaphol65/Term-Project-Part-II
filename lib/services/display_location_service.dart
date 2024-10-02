import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWithMarker extends StatefulWidget {
  final double lat;
  final double long;
  const MapWithMarker({super.key, required this.lat, required this.long});

  @override
  State<MapWithMarker> createState() => _MapWithMarkerState();
}

class _MapWithMarkerState extends State<MapWithMarker> {
  // default constructor
  late MapController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey, // Adjust the color to match your design
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        height: 400, // Set the height of map
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: FlutterMap(
          options: MapOptions(
            initialCenter:
                LatLng(widget.lat, widget.long), // Center the map over London
            initialZoom: 11,
          ),
          children: [
            TileLayer(
              // Display map tiles from any source
              urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
              userAgentPackageName: 'com.example.app',
              // And many more recommended properties!
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point:
                      LatLng(widget.lat, widget.long), // Position of the marker
                  width: 80.0,
                  height: 80.0,
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
