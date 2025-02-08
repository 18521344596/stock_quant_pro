# 页面路由文档

## 路由结构

```
/                   # 根路由
├── /login         # 登录页面
└── /home          # 主页面（需要认证）
    ├── /market    # 市场行情页面
    │   ├── /hot       # 热门股票标签页
    │   ├── /watchlist # 我的自选标签页
    │   └── /quotes    # 市场行情标签页
    ├── /trading   # 交易页面
    ├── /strategy  # 量化策略页面
    └── /profile   # 个人中心页面
```

## 主要页面

### 1. 认证页面

- **登录** (`LoginScreen`)
  - 路由: `/login`
  - 功能:
    - 用户登录表单
    - 账号密码验证
    - 登录状态管理
    - 自动跳转到主页

### 2. 底部导航页面

底部导航栏包含4个主要页面，使用 `AutoTabsRouter` 实现无状态切换：

- **市场行情** (`MarketScreen`)
  - 路由: `/market`
  - 图标: `Icons.show_chart`
  - 包含三个子标签页

- **交易** (`TradingScreen`)
  - 路由: `/trading`
  - 图标: `Icons.currency_exchange`

- **策略** (`StrategyScreen`)
  - 路由: `/strategy`
  - 图标: `Icons.auto_graph`

- **我的** (`ProfileScreen`)
  - 路由: `/profile`
  - 图标: `Icons.person`

### 3. 市场行情子页面

市场行情页面使用 `AutoTabsRouter.tabBar` 实现三个标签页，支持左右滑动切换：

- **热门股票** (`HotStocksScreen`)
  - 路由: `/market/hot`
  - 展示热门交易股票列表

- **我的自选** (`WatchlistScreen`)
  - 路由: `/market/watchlist`
  - 展示用户关注的股票列表

- **市场行情** (`QuotesScreen`)
  - 路由: `/market/quotes`
  - 展示整体市场行情数据

## 路由实现

### 路由配置

使用 `auto_route` 包实现路由管理，主要配置文件：
- `lib/presentation/routes/app_router.dart`
- `lib/presentation/routes/app_router.gr.dart`（自动生成）

```dart
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/login',
      page: LoginRoute.page,
    ),
    AutoRoute(
      path: '/',
      page: HomeRoute.page,
      children: [
        AutoRoute(
          path: 'market',
          page: MarketRoute.page,
          children: [
            AutoRoute(path: 'hot', page: HotStocksRoute.page),
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
```

### 认证路由守卫

使用 `AutoRoute` 的路由守卫功能实现认证保护：

```dart
@override
Future<bool> canNavigate(NavigationResolver resolver) async {
  // 检查是否需要认证
  if (resolver.route.requiresAuth && !isAuthenticated) {
    // 重定向到登录页面
    redirectToLogin();
    return false;
  }
  return true;
}
```

### 页面导航

1. **底部导航栏切换**
```dart
BottomNavigationBar(
  currentIndex: tabsRouter.activeIndex,
  onTap: tabsRouter.setActiveIndex,
  type: BottomNavigationBarType.fixed,
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: '行情'),
    BottomNavigationBarItem(icon: Icon(Icons.currency_exchange), label: '交易'),
    BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: '策略'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我'),
  ],
)
```

2. **市场行情标签页切换**
```dart
TabBar(
  controller: controller,
  tabs: const [
    Tab(text: '热门股票'),
    Tab(text: '我的自选'),
    Tab(text: '市场行情'),
  ],
)
```

## 特性

1. **状态保持**
   - 底部导航切换时保持各页面状态
   - 标签页切换时保持页面状态

2. **手势支持**
   - 支持左右滑动切换市场行情标签页
   - 支持底部导航栏点击切换

3. **深度链接**
   - 支持直接通过路由地址访问指定页面
   - 支持路由历史记录管理

4. **认证保护**
   - 未登录用户自动重定向到登录页
   - 登录成功后自动跳转到之前的页面
   - 支持记住登录状态

## 开发说明

1. **添加新页面流程**
   - 创建页面组件并添加 `@RoutePage()` 注解
   - 在 `app_router.dart` 中添加路由配置
   - 运行代码生成命令更新路由代码

2. **代码生成**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. **注意事项**
   - 所有页面组件都需要添加 `@RoutePage()` 注解
   - 路由路径使用小写字母和下划线
   - 确保路由名称唯一 

4. **认证相关**
   - 使用 `AuthController` 管理认证状态
   - 实现 `RouteGuard` 保护需要认证的路由
   - 使用 `SharedPreferences` 持久化登录状态 