import 'package:buttons_hub_mobile_dev/pages/main_layout_page/models/home_layout.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/main_layout_page/main_layout.page.dart';

void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.light,
    initialRoute: '/home',
    debugShowCheckedModeBanner: false,
    routes: {
      '/home': (context) => ChangeNotifierProvider<HomeLayoutModel>(
        create: (context) => HomeLayoutModel(),
        child: const MainLayoutPage(),
      ),
      '/login': (context) => const LoginLayoutPage(),
    },
  ));
}

class LoginLayoutPage  extends StatelessWidget{
  const LoginLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Hello, world!');
  }
}
