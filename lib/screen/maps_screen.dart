import 'package:exam_planner/data/directions_repository.dart';
import 'package:exam_planner/model/directions.dart';
import 'package:exam_planner/util/location_utils.dart';
import 'package:exam_planner/util/notification_api.dart';
import 'package:exam_planner/widget/appbar_button.dart';
import 'package:exam_planner/widget/map/map_field.dart';
import 'package:exam_planner/widget/map/map_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsExamScreen extends StatefulWidget {
  static const routeName = '/exam/map';

  const MapsExamScreen({Key? key}) : super(key: key);

  @override
  State<MapsExamScreen> createState() => _MapsExamScreenState();
}

class _MapsExamScreenState extends State<MapsExamScreen> {
  List<String> locationNotifications = <String>[];

  late String _subjectName;
  late GoogleMapController _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;

  void _setOriginMarker(LatLng? position) {
    if (position != null && mounted) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: position,
        );
      });
    }
  }

  void _setDestinationMarker(LatLng? position) {
    if (position != null && mounted) {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: position,
        );
      });
    }
  }

  void _setDistance(LatLng? origin, LatLng? destination) async {
    if (mounted) {
      var directions =
          await DirectionsRepository.getDirections(origin!, destination!);
      if (directions == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error when trying to access the Google Maps API'),
          duration: Duration(seconds: 3),
        ));
      } else {
        setState(() {
          _info = directions;
          checkNotifications(directions.totalDistance);
        });
      }
    }
  }

  void _setMarkers(LatLng? origin, LatLng? destination) {
    if (_origin == null &&
        _destination == null &&
        origin != null &&
        destination != null) {
      _setOriginMarker(origin);
      _setDestinationMarker(destination);

      _setDistance(origin, destination);
    }
  }

  void checkNotifications(String distance) {
    if (!locationNotifications.contains(distance)) {
      if (distance == "5 km" || double.parse(distance.split(" ")[0]) <= 5.0) {
        NotificationApi.showLocationNotification(_subjectName, distance);
      } else if (distance == "1 km" ||
          double.parse(distance.split(" ")[0]) <= 1.0) {
        NotificationApi.showLocationNotification(_subjectName, distance);
      } else if (distance == "0.1 km" ||
          double.parse(distance.split(" ")[0]) <= 0.1) {
        NotificationApi.showLocationNotification(_subjectName, distance);
      }
      locationNotifications.add(distance);
    }
  }

  void _listenForLocation() {
    LocationUtils.location.onLocationChanged
        .listen((LocationData currentLocation) {
      LatLng newOriginPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      if (_origin!.position.latitude != newOriginPosition.latitude ||
          _origin!.position.longitude != newOriginPosition.longitude) {
        _setDistance(newOriginPosition, _destination!.position);
        _setOriginMarker(newOriginPosition);
      }
    });
  }

  void _setController(GoogleMapController controller) {
    _googleMapController = controller;
  }

  Future<void> Function()? _originFunction() {
    return (_origin != null)
        ? () =>
            _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _origin!.position,
                zoom: 14.5,
                tilt: 50.0,
              ),
            ))
        : null;
  }

  Future<void> Function()? _destinationFunction() {
    return (_destination != null)
        ? () =>
            _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _destination!.position,
                zoom: 14.5,
                tilt: 50.0,
              ),
            ))
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as List<Object?>;
    final _userOrigin = arguments[0] as LatLng?;
    final _examDestination = arguments[1] as LatLng?;
    final _examName = arguments[2] as String?;
    _subjectName = _examName!;
    _setMarkers(_userOrigin, _examDestination);
    _listenForLocation();

    return Scaffold(
      appBar: AppBar(
        title: Tooltip(
          message: _examName.toString(),
          child: Text(_examName.toString()),
        ),
        actions: [
          AppBarButton(_originFunction, 'ORIGIN'),
          AppBarButton(_destinationFunction, 'DEST'),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MapField(_setController, null, _origin, _destination, _info),
          if (_info != null)
            MapInfo('${_info!.totalDistance}, ${_info!.totalDuration}'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.00)
              : CameraUpdate.newCameraPosition(
                  LocationUtils.initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
}
