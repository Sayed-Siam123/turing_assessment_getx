import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loggy/loggy.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:device_preview/device_preview.dart';
import 'package:turing_assessment_getx/routes/app_pages.dart';
import 'package:turing_assessment_getx/theme/theme_data.dart';

void main() async{
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(desktop: 800, tablet: 550, watch: 200),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((_) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(),
      ),
    );
    //configLoading();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //builder: EasyLoading.init(),
      theme: ThemeConfig.lightTheme,
      enableLog: true,
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.fade,
      getPages: AppPages.routes,
      smartManagement: SmartManagement.keepFactory,
      title: 'Turing Assessment',
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}