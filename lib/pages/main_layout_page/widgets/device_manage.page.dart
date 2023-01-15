import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;
import '../models/device.model.dart';
import '../models/device_type.enum.dart';

class DeviceManagePage extends StatefulWidget {
  const DeviceManagePage({Key? key, required this.selectedDevice})
      : super(key: key);
  final Device selectedDevice;

  @override
  State<DeviceManagePage> createState() => _DeviceManagePageState();
}

class _DeviceManagePageState extends State<DeviceManagePage> {
  bool _isActivated = false;
  double _brightness = 0;
  Color _color = Colors.white;
  String command = '';

  @override
  Widget build(BuildContext context) {
    Widget getBody(Device device) {
      switch (device.type) {
        case DeviceType.lamp:
          return SwitchListTile(
              value: _isActivated,
              secondary: const Icon(Icons.lightbulb_outline),
              title: Text(_isActivated ? 'Включено' : 'Выключено'),
              onChanged: (bool value) => {
                    setState(() {
                      _isActivated = value;
                      command = value ? 'ON' : 'OFF';
                      http.post(
                        Uri.parse('http://46.229.100.2:45633/renter/sendCommand'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          'deviceId': device.deviceID.toString(),
                          'rentId': '2',
                          'command': command
                        })
                      );
                    })
                  });
        case DeviceType.lampDimmable:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${(_brightness * 100).ceil()}%'),
              Slider(
                  value: _brightness,
                  divisions: 100,
                  onChanged: (double value) => {
                        setState(() {
                          _brightness = value;
                          command = (value * 100).ceil().toString();
                          http.post(
                              Uri.parse('http://46.229.100.2:45633/renter/sendCommand'),
                              headers: <String, String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, String>{
                                'deviceId': device.deviceID.toString(),
                                'rentId': '2',
                                'command': command
                              })
                          );
                        })
                      })
            ],
          );
        case DeviceType.lampColor:
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ColorPicker(
                    pickerColor: _color,
                    enableAlpha: false,
                    onColorChanged: (Color value) {
                      _color = value;
                    }),
                ElevatedButton(
                    onPressed: () => {
                          setState(() {
                            var hsvColor = HSVColor.fromColor(_color);
                            command =
                                '${hsvColor.hue.ceil()},${(hsvColor.saturation*100).ceil()},${(hsvColor.value*100).ceil()}';
                            http.post(
                                Uri.parse('http://46.229.100.2:45633/renter/sendCommand'),
                                headers: <String, String>{
                                  'Content-Type': 'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, String>{
                                  'deviceId': device.deviceID.toString(),
                                  'rentId': '2',
                                  'command': command
                                })
                            );
                          })
                        },
                    child: const Text('Сохранить цвет'))
              ]);
        case DeviceType.lampAll:
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${(_brightness * 100).ceil()}%'),
                Slider(
                    value: _brightness,
                    divisions: 100,
                    onChanged: (double value) => {
                      setState(() {
                        _brightness = value;
                        command = (value * 100).ceil().toString();
                        http.post(
                            Uri.parse('http://46.229.100.2:45633/renter/sendCommand'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'deviceId': device.deviceID.toString(),
                              'rentId': '2',
                              'command': command
                            })
                        );
                      })
                    }),
                ColorPicker(
                    pickerColor: _color,
                    enableAlpha: false,
                    onColorChanged: (Color value) {
                      _color = value;
                    }),
                ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        var hsvColor = HSVColor.fromColor(_color);
                        command =
                        '${hsvColor.hue.ceil()},${(hsvColor.saturation*100).ceil()},${(hsvColor.value*100).ceil()}';
                        http.post(
                            Uri.parse('http://46.229.100.2:45633/renter/sendCommand'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'deviceId': device.deviceID.toString(),
                              'rentId': '2',
                              'command': command
                            })
                        );
                      })
                    },
                    child: const Text('Сохранить цвет')),
              ]);
        default:
          return const Text('');
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.selectedDevice.name),
          titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: getBody(widget.selectedDevice),
          ),
        ));
  }
}
