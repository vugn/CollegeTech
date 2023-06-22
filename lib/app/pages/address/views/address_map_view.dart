import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressFullMap extends StatefulWidget {
  const AddressFullMap({super.key});

  @override
  State<StatefulWidget> createState() => AddressFullMapState();
}

typedef MarkerUpdateAction = Marker Function(Marker marker);

class AddressFullMapState extends State<AddressFullMap> {
  AddressFullMapState();
  GoogleMapController? controller;
  Map<MarkerId, Marker> markers = Get.arguments['marker'];
  MarkerId? selectedMarker;
  LatLng? markerPosition;

  // ignore: use_setters_to_change_properties
  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;

        markerPosition = null;
      });
    }
  }

  Future<void> _onMarkerDrag(MarkerId markerId, LatLng newPosition) async {
    setState(() {
      markerPosition = newPosition;
    });
  }

  Future<void> _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        markerPosition = null;
      });
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                      ],
                    )));
          });
    }
  }

  // void _add() {
  //   final int markerCount = markers.length;

  //   if (markerCount == 12) {
  //     return;
  //   }

  //   final String markerIdVal = 'marker_id_$_markerIdCounter';
  //   _markerIdCounter++;
  //   final MarkerId markerId = MarkerId(markerIdVal);

  //   final Marker marker = Marker(
  //     markerId: markerId,
  //     position: LatLng(
  //       center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
  //       center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
  //     ),
  //     infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
  //     onTap: () => _onMarkerTapped(markerId),
  //     onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
  //     onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
  //   );

  //   setState(() {
  //     markers[markerId] = marker;
  //   });
  // }

  Future<void> _draggable(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;
    setState(() {
      markers[markerId] = marker.copyWith(
        draggableParam: !marker.draggable,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: Get.arguments['userPosition'],
                    zoom: 20,
                  ),
                  markers: Set<Marker>.of(markers.values),
                ),
              ),
            ],
          ),
          Visibility(
            visible: markerPosition != null,
            child: Container(
              color: Colors.white70,
              height: 30,
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  if (markerPosition == null)
                    Container()
                  else
                    Expanded(child: Text('lat: ${markerPosition!.latitude}')),
                  if (markerPosition == null)
                    Container()
                  else
                    Expanded(child: Text('lng: ${markerPosition!.longitude}')),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
