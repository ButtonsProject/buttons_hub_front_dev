import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/home_layout.model.dart';
import 'widgets/apartment_manage.widget.dart';
import 'widgets/home.widget.dart';

class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeLayoutModel>(context);
    model.controller = PageController();

    void onTapped(int index) {
      model.selectedNavigationIndex = index;
      model.controller.animateToPage(index,
          curve: Curves.easeIn, duration: const Duration(milliseconds: 100));
    }

    void onPageChanged(int index) {
      model.selectedNavigationIndex = index;
    }

    String getAppBarTitle() {
      switch (model.selectedNavigationIndex) {
        case 0:
          return 'Главная';
        case 1:
          return 'Управление';
        case 2:
          return 'Настройки';
        default:
          return 'Главная';
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => {},
          )
        ],
        actionsIconTheme: const IconThemeData(color: Colors.black, size: 36),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(getAppBarTitle()),
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500),
      ),
      body: PageView(
        controller: model.controller,
        children: [
          const HomeWidget(),
          model.selectedApartment != null
              ? const ApartmentManageWidget()
              : const Center(child: Text('Выберите апартаменты')),
          Container(color: Colors.greenAccent),
        ],
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: model.selectedNavigationIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Главная'),
          BottomNavigationBarItem(
              icon: Icon(Icons.device_hub), label: 'Управление'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настроки')
        ],
        onTap: onTapped,
      ),
    );
  }
}
