import 'package:cuevaDelRecambio/domain/services/providers/theme_provider.dart';
import 'package:cuevaDelRecambio/ui/pages/home/cart_page.dart';
import 'package:cuevaDelRecambio/ui/pages/home/home_page.dart';
import 'package:cuevaDelRecambio/ui/pages/home/profile/user_page.dart';
import 'package:cuevaDelRecambio/ui/themes/dark_theme.dart';
import 'package:cuevaDelRecambio/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  // TODO! Finish app.
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
            labelColor: Provider.of<ThemeProvider>(context).isDarkMode
                ? DarkTheme.primaryColor
                : LightTheme.primaryColor,
            unselectedLabelColor: Provider.of<ThemeProvider>(context).isDarkMode
                ? DarkTheme.lightColor
                : LightTheme.lightColor,
            labelStyle: TextStyle(
                backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
                    ? DarkTheme.backgroundColor
                    : LightTheme.backgroundColor),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5),
          ),
        ));
  }
}
