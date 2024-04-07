import 'package:flutter/foundation.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'core/injection_container.dart' as di;
import 'export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];

  await di.init();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: kPrimaryColor));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      const RequestsInspector(
        enabled: kDebugMode,
        showInspectorOn: ShowInspectorOn.LongPress,
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  static BuildContext? appContext;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return ScreenUtilInit(
        designSize: const Size(baseWidth, baseHeight),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.routes,
          );
        });
  }
}
