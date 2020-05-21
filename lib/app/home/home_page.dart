import 'package:flutter/material.dart';
import 'package:timetracker/app/home/account/account_page.dart';
import 'package:timetracker/app/home/entries/entries_page.dart';
import 'package:timetracker/app/home/tab_items.dart';
import 'cupertino_home_scaffold.dart';
import 'jobs/jobs_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;

  final Map<TabItem,GlobalKey<NavigatorState>> navigatorKey = {
    TabItem.jobs:GlobalKey<NavigatorState>(),
    TabItem.entries:GlobalKey<NavigatorState>(),
    TabItem.account:GlobalKey<NavigatorState>(),
  };


  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries: (context) => EntriesPage.create(context),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if(tabItem == _currentTab){
//      pop to first root
    navigatorKey[tabItem].currentState.popUntil((route) => route.isFirst);
    }else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async=>!await navigatorKey[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKey: navigatorKey,
      ),
    );
  }

}
