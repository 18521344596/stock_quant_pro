import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../routes/app_router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        MarketRoute(),
        TradingRoute(),
        StrategyRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.show_chart), label: '行情'),
              NavigationDestination(icon: Icon(Icons.currency_exchange), label: '交易'),
              NavigationDestination(icon: Icon(Icons.auto_graph), label: '策略'),
              NavigationDestination(icon: Icon(Icons.person), label: '我'),
            ],
          ),
        );
      },
    );
  }
} 