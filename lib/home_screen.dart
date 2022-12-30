import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cash_helper.dart';
import 'package:news_app/cubit.dart';
import 'package:news_app/dio_helper.dart';
import 'package:news_app/search.dart';
import 'package:news_app/states.dart';
import 'app_cubit.dart';
import 'main.dart';
import 'search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsState> (
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${NewsCubit.get(context).titles[NewsCubit.get(context).currentIndex]}'
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => Search()
                        )
                    );
                  },
                  icon: Icon(
                    Icons.search
                  )
              ),
              IconButton(
                  onPressed: () {
                    CashHelper.removeTheme(key: 'isDark');
                    AppCubit.get(context).changeThemMode();
                  },
                  icon: Icon(
                    Icons.brightness_4_outlined
                  )
              )
            ],
          ),
          body: NewsCubit.get(context).screens[NewsCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: NewsCubit.get(context).currentIndex,
            items: NewsCubit.get(context).listOfItem,
            onTap: (index) {
              NewsCubit.get(context).changNavBarButton(index);
            } ,
          ),
        );
      },
    );
  }
}
