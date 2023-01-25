
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layouts/news_app/cubit/states.dart';
import 'package:my_app/modules/business/business_screen.dart';
import 'package:my_app/modules/science/science_screen.dart';
import 'package:my_app/modules/sports/sports_screen.dart';
import 'package:my_app/shared/network/local/cash_helper.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';



class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science'),

  ];

  void changeBottomNavState(int index){
    currentIndex = index;
    if(index==1) {
      getSports();
    }
    if(index==2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }
  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> business = [];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '6ffc9192911a4a24b75d5563849af366',
        },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState());
    });
  }

  List<dynamic> sports = [];
  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '6ffc9192911a4a24b75d5563849af366',
        },
      ).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState());
      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];
  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '6ffc9192911a4a24b75d5563849af366',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState());
      });
    }
    else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<dynamic> search = [];
  void getSearch(String? value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '6ffc9192911a4a24b75d5563849af366',
        }
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState());
    });
    }





  bool isDark = false;
  void changeAppMode({ bool? fromShared}){
    if(fromShared != null)
      isDark = fromShared;
    else
      isDark = !isDark;
    CashHelper.putData(key: 'isDark', value: isDark).then((value) { emit(NewsChangeAppState());});

  }

}