import 'package:centavo_tcc/screens/account/account_screen.dart';
import 'package:centavo_tcc/screens/donate/donate_screen.dart';
import 'package:centavo_tcc/screens/home/home_screen.dart';
import 'package:centavo_tcc/screens/favorites/favorites_screen.dart';
import 'package:centavo_tcc/stores/page_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class BaseScreen extends StatefulWidget {

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  void initState() {
    super.initState();

    reaction(
            (_) => pageStore.page,
            (page) => pageController.jumpToPage(page)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          DonateScreen(),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.yellow,
          ),
          FavoritesScreen(),
          AccountScreen(),
        ],
      ),
    );
  }
}
