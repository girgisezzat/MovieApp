import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_app/models/movie_app/movie_model.dart';
import 'package:movie_app/shared/bloc_observer.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/local/cache_helper.dart';
import 'package:movie_app/shared/network/remote/dio_helper.dart';
import 'package:movie_app/shared/styles/themes.dart';
import 'package:overlay_support/overlay_support.dart';
import 'layout/movie_app/cubit/cubit.dart';
import 'layout/movie_app/movie_layout.dart';
import 'modules/movie_app/login/login_screen.dart';


void main() async {
  // it ensures that every thing in method done then run application
  //بيتاكد ان كل حاججة هنا ف الميثود خلصت وبعدين يفتح الابليكاشن
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token');

  Widget startWidget = MovieLoginScreen();
  if (token != null) {
    startWidget = MoviesLayout();
    email = CacheHelper.getData(key: 'email');
    password = CacheHelper.getData(key: 'password');
    sessionId = CacheHelper.getData(key: 'sessionId');
    print(email);
    print(password);
    print(token);
    print(sessionId);
  }

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp(startScreen: startWidget));
}

class MyApp extends StatelessWidget {
  Widget startScreen;
  MyApp({Key? key,  required this.startScreen}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          //MovieAppMain
          create: (BuildContext context) => MoviesCubit()
            ..getPopularMovies(1)
            ..getTopRatedMovies(1)
            ..getNowPlayingMovies(1)
            ..getMoviesGenres()
            ..getListData()
        ),
      ],
      child:  OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: startScreen,
        ),
      ),
    );
  }
}


