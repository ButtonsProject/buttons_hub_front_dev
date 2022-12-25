import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/state_handler.dart';
import '../models/device.model.dart';
import '../models/device_type.enum.dart';
import '../models/home_layout.model.dart';
import 'device_manage.page.dart';

class ApartmentManageWidget extends StatelessWidget {
  const ApartmentManageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeLayoutModel>(context);
    DeviceHandler _handler = DeviceHandler();
    List<Device> deviceState =
    _handler.getDevices(model.selectedApartment?.apartID);
    Future<List<Device>> futureDevState = _handler.getDevicesFromApi(model.selectedApartment?.apartID);

    String getImage(DeviceType type) {
      switch (type) {
        case DeviceType.lamp:
          return 'assets/images/device_types/lamp.png';
        case DeviceType.lampColor:
        case DeviceType.lampDimmable:
          return 'assets/images/device_types/smart-lamp.png';
        default:
          return '';
      }
    }

    void onTapped(Device device) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => DeviceManagePage(selectedDevice: device)));
    }

    return FutureBuilder(
        future: futureDevState,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 23),
                  child: Text(
                    model.selectedApartment?.name ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                for (var device in snapshot.data! as List<Device>)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
                    child: GestureDetector(
                      onTap: () => onTapped(device),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            ListTile(
                              title: Text(device.name),
                              leading: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(getImage(device.type)),
                                          fit: BoxFit.fitWidth,
                                          alignment: FractionalOffset.center)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          return const Center(child: Text('Выберите апартаменты'));
        });


    /*return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 23),
          child: Text(
            model.selectedApartment?.name ?? '',
            style: const TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ),
        for (var device in deviceState)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
            child: GestureDetector(
              onTap: () => onTapped(device),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      title: Text(device.name),
                      leading: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(getImage(device.type)),
                                  fit: BoxFit.fitWidth,
                                  alignment: FractionalOffset.center)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    );*/
  }
}
