import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/sciences_news.dart';
import 'package:news_app/sports_news.dart';
import 'package:news_app/states.dart';
import 'business_new.dart';
import 'dio_helper.dart';
import 'cash_helper.dart';
import 'main.dart';


class NewsCubit extends Cubit<NewsState>{
  NewsCubit() : super(NewsInitialState());
  static get(BuildContext context) => BlocProvider.of<NewsCubit>(context);

  int currentIndex = 0;
  List<dynamic> businessNews = [];
  List<dynamic> sportsNews = [];
  List<dynamic> sciencesNews = [];
  List<dynamic> searchNews = [];

  List<Widget> screens = [
    BusinessNews(),
    SportsNews(),
    SciencesNews(),
  ];
  List<BottomNavigationBarItem> listOfItem = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Sciences'
    ),
  ];
  List<Function> screensLists = [];
  List<String> titles = ['Business News', 'Sports News', 'Sciences News', 'Settings'];

  void changNavBarButton (int index) {
    if ( index == 1) {
      getSportsData();
    } else {
      getSciencesData();
    }
    currentIndex = index;
    emit(ButtonNavBarState());
  }

  void getBusinessData() {
    emit(GetBusinessDataLoading());
    DioHelper.get(
        path: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category' : 'business',
          'apiKey' : '69cca983d4cb4cb1b55ec89e6fd19d06'
        }
    ).then((value) {
      businessNews = value.data['articles'];
      emit(GetBusinessDataSuccess());
    }).catchError((error) {
      emit(GetBusinessDataError(error));
      print(error);
    });
  }
  void getSportsData() {
    emit(GetSportsDataLoading());
    if(sportsNews.length == 0) {
      DioHelper.get(
          path: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category' : 'sports',
            'apiKey' : '69cca983d4cb4cb1b55ec89e6fd19d06'
          }
      ).then((value) {
        sportsNews = value.data['articles'];
        emit(GetSportsDataSuccess());
      }).catchError((error) {
        emit(GetSportsDataError(error));
        print(error);
      });
    }else {
      emit(GetSportsDataSuccess());
    }

  }
  void getSciencesData() {
    emit(GetSciencesDataLoading());
    if(sportsNews.length == 0) {
      DioHelper.get(
          path: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category' : 'science',
            'apiKey' : '69cca983d4cb4cb1b55ec89e6fd19d06'
          }
      ).then((value) {
        sciencesNews = value.data['articles'];
        emit(GetSciencesDataSuccess());
      }).catchError((error) {
        emit(GetSciencesDataError(error));
        print(error);
      });
    } else {
      emit(GetSciencesDataSuccess());
    }

  }

  void getSearchData(String value) {
    emit(GetSearchDataLoading());
      DioHelper.get(
          path: 'v2/everything',
          query: {
            'q' : value,
            'apiKey' : '69cca983d4cb4cb1b55ec89e6fd19d06'
          }
      ).then((value) {
        searchNews = value.data['articles'];
        print(searchNews);
        emit(GetSearchDataSuccess());
      }).catchError((error) {
        emit(GetSearchDataError(error));
        print(error);
      });


  }



}