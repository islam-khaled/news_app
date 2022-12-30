import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cash_helper.dart';
import 'cubit.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialState());

  static get(BuildContext context) => BlocProvider.of<AppCubit>(context);

  bool isDark = false;
  void changeThemMode({ bool? valueFromShared}) {
    if(valueFromShared != null){
      isDark = valueFromShared;
      emit(ChangeThemeModeState());
    } else {
      isDark = !isDark;
      CashHelper.setBool(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeModeState());
      });
    }



  }
}