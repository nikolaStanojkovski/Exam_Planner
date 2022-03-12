import 'package:exam_planner/model/directions.dart';
import 'package:exam_planner/util/location_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapField extends StatelessWidget {
  final Function(GoogleMapController)? _setControllerFunction;
  final Function(LatLng)? _setLocationFunction;
  final Marker? _origin;
  final Marker? _destination;
  final Directions? _info;

  const MapField(this._setControllerFunction, this._setLocationFunction,
      this._origin, this._destination, this._info,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: LocationUtils.initialCameraPosition,
      onMapCreated: (controller) => (_setControllerFunction != null)
          ? _setControllerFunction!(controller)
          : null,
      markers: {
        if (_origin != null) _origin!,
        if (_destination != null) _destination!,
      },
      polylines: {
        if (_info != null)
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Colors.red,
            width: 5,
            points: _info!.polylinePoints
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
      },
      onTap: (latLng) =>
          (_setLocationFunction != null) ? _setLocationFunction!(latLng) : null,
    );
  }
}
