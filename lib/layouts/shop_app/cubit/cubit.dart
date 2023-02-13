import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layouts/shop_app/cubit/states.dart';
import 'package:my_app/models/shop_app/categories_model.dart';
import 'package:my_app/models/shop_app/change_favorite_model.dart';
import 'package:my_app/models/shop_app/favotites_model.dart';
import 'package:my_app/models/shop_app/home_model.dart';
import 'package:my_app/models/shop_app/login_model.dart';
import 'package:my_app/modules/shop_app/categories/categories_screen.dart';
import 'package:my_app/modules/shop_app/products/products_screen.dart';
import 'package:my_app/modules/shop_app/settings/settings_screen.dart';
import 'package:my_app/shared/components/constants.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';

import '../../../modules/shop_app/favorite/favorite_screen.dart';
import '../../../shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;

  CategoriesModel? categoriesModel;

  Map<int, bool> favorites = {};
  ChangeFavoriteModel? changeFavoriteModel;
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];
  FavoritesModel? favoritesModel;
  ShopLoginModel? userDataModel;
  void getHomeData()
  {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(
        url:HOME,
        token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favorites.addAll({
          element.id:element.inFavorite
        });
      }
      emit(ShopSuccessHomeDataStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataStates());
    });
  }

  void getCategoriesData()
  {
    DioHelper.getData(
      url: GET_GATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesStates());
    });
  }


  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  void changeFavorites(int productId)
  {

    favorites[productId] =! favorites[productId]!;
    emit(ShopChangeFavoritesStates());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id': productId,
        },
      token: token,

    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoriteModel!.status){
        favorites[productId] =! favorites[productId]!;
      } else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesStates(changeFavoriteModel!));
    }).catchError((error){
      favorites[productId] =! favorites[productId]!;
      emit(ShopErrorChangeFavoritesStates());
    });
  }

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(
        url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesStates());
    });
  }

  void getUserData()
  {
    emit(ShopLoadingGetUserDataStates());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userDataModel = ShopLoginModel.fromJson(value.data);
      print(userDataModel!.data.name);
      emit(ShopSuccessGetUserDataStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataStates());
    });
  }
  void updateUserData({
    required String name,
    required String email,
    required String phone,
})
  {
    emit(ShopLoadingUpdateUserDataStates());
    DioHelper.putData(
      url: UPDATEPROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {
      userDataModel = ShopLoginModel.fromJson(value.data);
      print(userDataModel!.data.name);
      emit(ShopSuccessUpdateUserDataStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserDataStates());
    });
  }
}