import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:teknisi_app/app/data/repositories/google_maps/maps_functions.dart';
import 'package:teknisi_app/app/pages/address/views/address_map_view.dart';

class AddressController extends GetxController {
  RxString text = ''.obs;
  late Rx<TextEditingController> addressController;
  final GoogleMapsFunctions _googleMapsFunctions = GoogleMapsFunctions();
  late LatLng userPosition;
  Completer<GoogleMapController> googleMapController = Completer();
  late LocationData? _locationData;
  final Location _location = Location();
  late Rx<CameraPosition> cameraPosition =
      const CameraPosition(target: LatLng(0, 0)).obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  late StreamSubscription<LocationData> locationSubscription;
  late LatLng finalPosition;

  @override
  void onInit() async {
    super.onInit();
    addressController = TextEditingController(text: text.value).obs;
    _locationData = await _googleMapsFunctions.getLocation();
    userPosition = LatLng(_locationData!.latitude!, _locationData!.longitude!);
    final GoogleMapController mapControllerComplete =
        await googleMapController.future;
    mapControllerComplete.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: userPosition, zoom: 19)));
    addMarker();
    locationSubscription =
        _location.onLocationChanged.listen((LocationData cLoc) async {
      userPosition = LatLng(cLoc.latitude!, cLoc.longitude!);
      updateMapCameraPosition();
    });
  }

  void onMapTapped() {
    Get.to(const AddressFullMap(), arguments: {
      "marker": Get.arguments['marker'],
      "userPosition": userPosition
    });
  }

  void addMarker() {
    markers.add(Marker(
      markerId: const MarkerId('userMarker'),
      infoWindow: const InfoWindow(
          title: "Geser Lokasi", snippet: 'Tahan tanda untuk geser lokasi'),
      position: userPosition,
      draggable: true,
      onDragEnd: (value) => finalPosition = value,
    ));
  }

  void removeMarker() {
    markers.removeWhere((element) => element.markerId.value == 'userMarker');
  }

  void updateMapCameraPosition() async {
    final GoogleMapController mapControllerComplete =
        await googleMapController.future;
    mapControllerComplete.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: userPosition, zoom: 19)));
    removeMarker();
    addMarker();
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController.complete(controller);
  }

  void onSubmit() {
    print(finalPosition);
  }
}
