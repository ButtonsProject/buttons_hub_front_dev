import 'dart:convert';
import '../models/apartment.model.dart';
import '../models/device.model.dart';
import 'package:http/http.dart' as http;

import '../models/device_type.enum.dart';

class DeviceHandler {
  final Map<int, List<Device>> _deviceState = {
    1: [Device(0, DeviceType.lamp, 'Основная лампа', 'Выключен')],
    2: [
      Device(0, DeviceType.lampDimmable, 'Лампа на кухне', 'Выключен'),
      Device(1, DeviceType.lampColor, 'Лампа в кабинете', 'Выключен'),
    ]
  };

  List<Device> getDevices(int? index) {
    return _deviceState[index] ?? [];
  }

  Future<List<Device>> getDevicesFromApi(int? index) async {
    if (index == null) {
      return [];
    }
    var response = await
        http.get(Uri.parse('http://46.229.100.2:45633/renter/getDevices?rentID=$index'));
    var devices = <Device>[];
    for (var dev in jsonDecode(utf8.decode(response.bodyBytes))){
      devices.add(Device.fromJson(dev));
    }

    return devices;
  }
}

class ApartmentHandler {
  final Map<int, List<Apartment>> _apartmentState = {
    1: [
      Apartment(
        1,
        'Комната по Мира',
        '22, улица Гагарина, Втузгородок, Кировский район, Екатеринбург',
        'assets/images/rent-1.png',
        DateTime.parse('2022-06-05T09:48:41.874Z'),
        DateTime.parse('2022-06-10T09:48:41.874Z'),
      ),
      Apartment(
          2,
          'Квартира по Ленина',
          '5А к1, проспект Ленина, Форум-Сити, Ленинский район, Екатеринбург',
          'assets/images/rent-2.jpg',
          DateTime.parse('2022-06-20T09:48:41.874Z'),
          DateTime.parse('2022-06-27T09:48:41.874Z')),
    ],
  };

  List<Apartment> getApartments(int index) {
    return _apartmentState[index] ?? [];
  }

  Future<List<Apartment>> getApartmentFromApi(int index) async {
    var response = await http.get(Uri.parse(
        'http://46.229.100.2:45633/renter/getRents?renterID=$index'));

    var apartments = <Apartment>[];
    if(response.statusCode == 200 || response.statusCode == 202) {
      for (var rent in jsonDecode(utf8.decode(response.bodyBytes))) {
        apartments.add(Apartment.fromJson(rent));
      }
    }

    return apartments;
  }
}
