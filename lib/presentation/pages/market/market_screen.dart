import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../routes/app_router.dart';

@RoutePage()
class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        HotStocksRoute(),
        WatchlistRoute(),
        QuotesRoute(),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Market'),
            bottom: TabBar(
              controller: controller,
              tabs: const [
                Tab(text: '热门股票'),
                Tab(text: '我的自选'),
                Tab(text: '市场行情'),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
} 