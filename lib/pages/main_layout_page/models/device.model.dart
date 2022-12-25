import 'device_type.enum.dart';

class Device {
  int deviceID;
  DeviceType type;
  String name;
  String state;

  Device(this.deviceID, this.type, this.name, this.state);

  factory Device.fromJson(Map<String, dynamic> json){
    return Device(
        json['id'],
        getType(json['type']),
        json['name'],
        json['state']
    );
  }
}

DeviceType getType(String type){
  switch (type){
    case 'Lamp':
      return DeviceType.lamp;
    case 'LAMP_DIMMABLE':
      return DeviceType.lampDimmable;
    case 'LAMP_COLOR':
      return DeviceType.lampColor;
    case 'LAMP_ALL':
      return DeviceType.lampAll;
    default:
      return DeviceType.none;
  }
}
