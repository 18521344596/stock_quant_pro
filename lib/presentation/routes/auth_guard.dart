import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.dart';

class AuthGuard extends AutoRouteGuard {
  final SharedPreferences _prefs;

  const AuthGuard(this._prefs);

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final bool isAuthenticated = _prefs.getBool('isAuthenticated') ?? false;
    
    if (isAuthenticated) {
      resolver.next(true);
    } else {
      await router.push(const LoginRoute());
    }
  }
} 