import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

class HomeController extends GetxController {
  var latitude = "Getting latitude...".obs;
  var longitude = "Getting longitude...".obs;
  var address = "Getting address...".obs;
  late StreamSubscription<Position> streamSubscription;

  @override
  void onInit() async{
    super.onInit();
    getLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
  }

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return Future.error('Location permissions are denied');
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are denied forever');
    }
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      latitude.value = "Latitude: ${position.latitude.toString()}";
      longitude.value = "Longitude: ${position.longitude.toString()}";
      getAddressFromLatLng(position);
    });
  }

  Future<void> getAddressFromLatLng(Position position) async {
    List<Placemark> p =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = p[0];
    address.value =
        "Addres: ${place.street}, ${place.postalCode}, ${place.locality}, ${place.country}";
  }
}
