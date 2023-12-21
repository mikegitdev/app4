import 'package:app4/presentation/utils/audo_player_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:app4/bloc/home/home_bloc.dart';
import 'package:app4/bloc/theme/theme_bloc.dart';
import 'package:app4/data/repositories/song_repository.dart';
import 'package:app4/data/services/hive_box.dart';
import 'package:app4/presentation/pages/splash_page.dart';
import 'package:app4/presentation/utils/app_router.dart';
import 'package:app4/presentation/utils/theme/app_theme_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/src/framework.dart';

Future<void> main() async {
  // initialize flutter engine
  WidgetsFlutterBinding.ensureInitialized();

  // ask for permission to access media if not granted
  if (!await Permission.mediaLibrary.isGranted) {
    await Permission.mediaLibrary.request();
  }

  // ask for notification permission if not granted
  if (!await Permission.notification.isGranted) {
    await Permission.notification.request();
  }

  // initialize hive
  await Hive.initFlutter();
  await Hive.openBox(HiveBox.boxName);

  // initialize audio service

  await AudioPlayerManager().init();
  runApp(ProviderScope(child: MyApp()));
  // run app
  // runApp(
  //   RepositoryProvider(
  //     create: (context) => SongRepository(),
  //     child: MultiBlocProvider(
  //       providers: [
  //         BlocProvider(
  //           create: (context) => ThemeBloc(),
  //         ),
  //         BlocProvider(
  //           create: (context) => HomeBloc(),
  //         ),
  //       ],
  //       child: const MyApp(),
  //     ),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: false,
        splitScreenMode: false,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Meloplay',
            theme: AppThemeData.getTheme(),
            home: const SplashPage(),
            onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
          );
        });
  }
}
