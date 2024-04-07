import 'package:tasks/assets.dart';
import 'package:tasks/core/feature/data/models/users_wrapper.dart';
import 'package:tasks/features/animated_splash/views/animated_splash_view.dart';
import 'package:tasks/features/home/presentation/add_task_page.dart';
import 'package:tasks/features/login/presentation/login/login_page.dart';
import 'package:tasks/features/home/presentation/page.dart';

import '../../export.dart';

part 'app_routes.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter._();

  static final GoRouter routes = GoRouter(navigatorKey: navKey, routes: [
    GoRoute(
      path: Routes.animatedSplash,
      builder: (context, state) => AnimatedSplash(
        imagePath: Assets.imagesLogo,
        home: sl<SharedPreferences>().containsKey(kToken)
            ? Routes.home
            : Routes.login,
        duration: 1000,
        type: AnimatedSplashType.StaticDuration,
        title: '',
      ),
    ),
    GoRoute(
      name: Routes.login,
      path: Routes.login,
      builder: (context, state) {
        return LoginPage();
      },
    ),
    GoRoute(
      name: Routes.home,
      path: Routes.home,
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      name: Routes.addTask,
      path: Routes.addTask,
      builder: (context, state) {
        return AddTaskPage(
          item: state.extra as Task?,
        );
      },
    ),
  ]);
}
