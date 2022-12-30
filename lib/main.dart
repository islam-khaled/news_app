import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cash_helper.dart';
import 'package:news_app/dio_helper.dart';
import 'package:news_app/states.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'app_cubit.dart';
import 'app_state.dart';
import 'cubit.dart';
import 'home_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isWindows)
  //    await DesktopWindow.setMinWindowSize(Size(650, 650));
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getBool(key: 'isDark');
  if(isDark == null){
    isDark = false;
  }
  runApp( NewsApp(isDark!));
}

// test git queries
class NewsApp extends StatelessWidget {
bool isDark;
NewsApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusinessData()..getSportsData()..getSciencesData()),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeThemMode(valueFromShared: isDark)),
      ],
        child: BlocConsumer<AppCubit, AppState> (
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      color: Colors.white,
                      elevation: 0.0,
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark
                      ),
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                      iconTheme: IconThemeData(
                          color: Colors.black,
                          size: 35
                      )
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.black,
                      showUnselectedLabels: true,
                      selectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      elevation: 20.0
                  ),
                  textTheme: TextTheme(
                    subtitle1: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black
                    ),
                  )
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.black26,
                appBarTheme: AppBarTheme(
                    color: Colors.black,
                    elevation: 0.0,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        statusBarIconBrightness: Brightness.light
                    ),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.white,
                        size: 35
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Colors.black,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.white,
                    showUnselectedLabels: true,
                    selectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    elevation: 20.0
                ),
                textTheme: TextTheme(
                    subtitle1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    )
                ),
              ),
              themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: ScreenTypeLayout(
                mobile: HomeScreen(),
                desktop: Center(child: Text('Desktop'),),
                breakpoints: ScreenBreakpoints(
                  desktop: 600,
                  watch: 350,
                  tablet: 350
                ),
              ),
            );
          },
        ),
      );
  }
}



