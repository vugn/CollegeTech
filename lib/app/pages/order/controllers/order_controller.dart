import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_auth.dart';
import 'package:teknisi_app/app/data/repositories/firebase/firebase_snapshots.dart';
import 'package:teknisi_app/app/data/repositories/firebase/orders/orders_functions.dart';
import 'package:teknisi_app/app/widgets/account_button.dart';
import 'package:teknisi_app/app/widgets/forms.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teknisi_app/app/widgets/indicator.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FirebaseOrdersFunctions firebaseOrdersFunctions =
      FirebaseOrdersFunctions();
  final FirebaseSnapshots firebaseSnapshots = FirebaseSnapshots();
  final FirebaseAuthentication firebaseAuth = FirebaseAuthentication();
  late Rx<TabController> tabBarController;

  RxString dateText = ''.obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  RxString timeText = ''.obs;
  Rx<TextEditingController> timeController = TextEditingController().obs;
  RxInt currentTabIndex = 0.obs;

  // Maps
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late GoogleMapController mapController;
  late LatLng userLocation;

  @override
  void onInit() {
    tabBarController = TabController(vsync: this, length: 2).obs;
    super.onInit();
  }

  @override
  void onClose() {
    tabBarController.value.dispose();
    super.onClose();
  }

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (pickedDate == null) {
      return;
    }
    dateController.value.text = parseDateTime(pickedDate.toString());
    dateText.value = parseDateTime(pickedDate.toString());
    update();
  }

  void pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) {
      return;
    }
    timeController.value.text = "${pickedTime.hour}:${pickedTime.minute}";
    timeText.value = "${pickedTime.hour}:${pickedTime.minute}";
    update();
  }

  String parseDateTime(String inputDate) {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(inputDate);
    String formattedDate = DateFormat('dd - MM - yyyy').format(dateTime);
    return formattedDate;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getOrders() async {
    try {
      var orders = await firebaseOrdersFunctions.getListOrdersTechnician();
      return orders;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  RxBool isFilled() {
    if (dateText.value.isNotEmpty && timeText.value.isNotEmpty) {
      return true.obs;
    } else {
      return false.obs;
    }
  }

  void showOrderDetail(dynamic orderData) {
    dateController.value.text = orderData['date_start'];
    timeController.value.text = orderData['time_start'];
    double lat = double.parse(orderData['latlng'].toString().split(',')[0]);
    double lng = double.parse(orderData['latlng'].toString().split(',')[1]);
    userLocation = LatLng(lat, lng);
    final marker = Marker(
      markerId: const MarkerId('userLocation'),
      position: userLocation,
      icon: BitmapDescriptor.defaultMarker,
    );
    markers[const MarkerId('userLocation')] = marker;
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 31),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mulai",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 14,
                          ))),
                      Obx(() => Row(
                            children: [
                              SizedBox(
                                width: 122,
                                child: CustomTextField(
                                  onTap: () {
                                    pickDate(context);
                                  },
                                  controller: dateController.value,
                                  hint: dateText.value.isEmpty
                                      ? 'Pilih Tanggal'
                                      : dateText.value,
                                  style: const TextStyle(fontSize: 12),
                                  readOnly: true,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                width: 85,
                                child: CustomTextField(
                                  onTap: () => pickTime(context),
                                  controller: timeController.value,
                                  hint: timeText.value.isEmpty
                                      ? 'Pilih Jam'
                                      : timeText.value,
                                  style: const TextStyle(fontSize: 12),
                                  readOnly: true,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lokasi",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 14,
                          ))),
                      SizedBox(
                        width: 221,
                        height: 144,
                        child: GoogleMap(
                          initialCameraPosition:
                              CameraPosition(target: userLocation, zoom: 15),
                          markers: markers.values.toSet(),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text("Deskripsi Lokasi",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              fontSize: 14,
                            ))),
                      ),
                      Container(
                        width: 221,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFF4F4F4)),
                        child: Text(orderData['address']),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AccountButton(
                      label: 'Masukkan Ke Jadwal',
                      isActive: dateText.value.isNotEmpty &&
                          timeText.value.isNotEmpty,
                      onTap: () {
                        if (isFilled().value) {
                          Indicator.showLoading();
                          firebaseOrdersFunctions.setOrder(
                              orderData['order_id'],
                              1,
                              dateText.value,
                              timeText.value);
                          Indicator.closeLoading();
                          Get.back();
                          Get.back();
                          update();
                          currentTabIndex.value = 1;
                          tabBarController.value.animateTo(1);
                        }
                      })
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
