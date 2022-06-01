import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/place.dart';

const mapboxApiKey =
    'pk.eyJ1Ijoic2hvbmVzazIwMDAiLCJhIjoiY2wzdHF0OHR1MGZjZzNrcnh6b2VyNHJtNyJ9.50Eh3tc1bobFa4hDRVDIrQ';
const mapboxUser = 'shonesk2000';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen({
    Key? key,
    this.initialLocation =
        const PlaceLocation(latitude: 37.422, longitude: -122.084),
    this.isSelecting = false,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<Marker> _markers = [];
  final List<Widget> _actions = [];

  LatLng? _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(
      () {
        _pickedLocation = position;
        _markers.add(
          Marker(
            width: 50.0,
            height: 50.0,
            point: _pickedLocation!,
            builder: (ctx) => const Icon(
              Icons.add_location,
              color: Colors.red,
              size: 40,
            ),
          ),
        );
        _actions.add(
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => Navigator.of(context).pop(_pickedLocation),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: _actions,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13.0,
          onTap: widget.isSelecting
              ? (tapPosition, latLong) => _selectLocation(latLong)
              : null,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/$mapboxUser/cl3u99lib002c14p7claduy1u/tiles/256/{z}/{x}/{y}@2x?access_token=$mapboxApiKey",
            additionalOptions: {
              'accessToken': mapboxApiKey,
              'id': 'mapbox.mapbox-streets-v8'
            },
          ),
          MarkerLayerOptions(
            markers: widget.isSelecting
                ? _markers
                : [
                    Marker(
                      width: 50.0,
                      height: 50.0,
                      point: _pickedLocation ??
                          LatLng(
                            widget.initialLocation.latitude,
                            widget.initialLocation.longitude,
                          ),
                      builder: (ctx) => const Icon(
                        Icons.add_location,
                        color: Colors.red,
                        size: 40,
                      ),
                    )
                  ],
          ),
        ],
      ),
    );
  }
}
