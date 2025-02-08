import 'package:auto_route/auto_route.dart';
import '../pages/login/login_screen.dart';
import '../pages/home/home_screen.dart';
import '../pages/market/market_screen.dart';
import '../pages/market/hot_stocks_screen.dart';
import '../pages/market/watchlist_screen.dart';
import '../pages/market/quotes_screen.dart';
import '../pages/trading/trading_screen.dart';
import '../pages/strategy/strategy_screen.dart';
import '../pages/profile/profile_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  factory AppRouter() => _instance;
  AppRouter._();
  static final AppRouter _instance = AppRouter._();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/login',
          page: LoginRoute.page,
        ),
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(
              path: 'market',
              page: MarketRoute.page,
              initial: true,
              children: [
                AutoRoute(path: 'hot', page: HotStocksRoute.page, initial: true),
                AutoRoute(path: 'watchlist', page: WatchlistRoute.page),
                AutoRoute(path: 'quotes', page: QuotesRoute.page),
              ],
            ),
            AutoRoute(path: 'trading', page: TradingRoute.page),
            AutoRoute(path: 'strategy', page: StrategyRoute.page),
            AutoRoute(path: 'profile', page: ProfileRoute.page),
          ],
        ),
      ];
} 