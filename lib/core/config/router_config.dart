import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../presentation/routes/auth_guard.dart';
import '../../presentation/routes/app_router.dart';
import '../services/router_service.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/stock_detail/stock_detail_page.dart';

class RouterConfiguration implements RouterService {
  final AuthGuard authGuard;
  final AppRouter appRouter;

  const RouterConfiguration({
    required this.authGuard,
    required this.appRouter,
  });

  @override
  RouterConfig<Object> get config => appRouter.config(
        navigatorObservers: observersBuilder
      );

  @override
  List<AutoRouteGuard> get guards => [authGuard];

  @override
  List<NavigatorObserver> Function() get observersBuilder => 
      () => [AutoRouteObserver()];
}

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomePage,
      initial: true,
      path: '/',
    ),
    AutoRoute(
      page: StockDetailPage,
      path: '/stock/:symbol',
    ),
  ],
)
class $AppRouter {}

final appRouter = AppRouter(); 