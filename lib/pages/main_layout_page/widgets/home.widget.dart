import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/state_handler.dart';
import '../models/apartment.model.dart';
import '../models/home_layout.model.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApartmentHandler _handler = ApartmentHandler();
    final model = Provider.of<HomeLayoutModel>(context);
    List<Apartment> apartmentState = _handler.getApartments(1);
    Future<List<Apartment>> futureApartState = _handler.getApartmentFromApi(1);

    void onTapped(Apartment apart) {
      model.selectedApartment = apart;
      model.selectedNavigationIndex = 1;
      model.controller.animateToPage(1,
          curve: Curves.easeIn, duration: const Duration(milliseconds: 100));
    }

    String formatDate(DateTime start, DateTime end) {
      return '${start.day ~/ 10 == 0 ? '0${start.day}' : start.day}.${start.month}.${start.year} '
          '- ${end.day}.${end.month}.${end.year}';
    }

    return FutureBuilder(
        future: futureApartState,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 23),
                  child: const Text(
                    'Апартаменты',
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                for (var apartment in snapshot.data! as List<Apartment>)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
                    child: GestureDetector(
                      onTap: () => onTapped(apartment),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 360 / 89,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(apartment.imgUrl),
                                        fit: BoxFit.fitWidth,
                                        alignment: FractionalOffset.center)),
                              ),
                            ),
                            ListTile(
                              title: Text(apartment.name),
                              subtitle: Text(formatDate(
                                  apartment.startRentTime, apartment.endRentTime)),
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

          return const Center(child: CircularProgressIndicator(
            color: Colors.black,
          ));
        });

    /*return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 23),
          child: const Text(
            'Жилье',
            style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ),
        for (var apartment in apartmentState)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
            child: GestureDetector(
              onTap: () => onTapped(apartment),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 360 / 89,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(apartment.imgUrl),
                                fit: BoxFit.fitWidth,
                                alignment: FractionalOffset.center)),
                      ),
                    ),
                    ListTile(
                      title: Text(apartment.name),
                      subtitle: Text(formatDate(
                          apartment.startRentTime, apartment.endRentTime)),
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
