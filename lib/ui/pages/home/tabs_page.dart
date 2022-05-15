import 'package:client_project/ui/pages/home/cart_page.dart';
import 'package:client_project/ui/pages/home/home_page.dart';
import 'package:client_project/ui/pages/home/user_page.dart';
import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:client_project/main.dart';

class TabsPage extends StatefulWidget {
  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  // ! Finish app.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
              controller: tabController,
              children: [HomePage(), CartPage(), UserPage()]),
          bottomNavigationBar: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.shopping_cart),
              ),
              Tab(
                icon: Icon(Icons.person),
              ),
            ],
            labelColor: MyApp.darkMode
                ? DarkTheme.primaryColor
                : LightTheme.primaryColor,
            unselectedLabelColor:
                MyApp.darkMode ? DarkTheme.lightColor : LightTheme.lightColor,
            labelStyle: TextStyle(
                backgroundColor: MyApp.darkMode
                    ? DarkTheme.backgroundColor
                    : LightTheme.backgroundColor),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5),
          ),
        ));
  }
}
