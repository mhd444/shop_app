import 'package:my_app/models/shop_app/change_favorite_model.dart';

abstract class ShopStates{}
class ShopInitialStates extends ShopStates{}

class ShopChangeBottomNavStates extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}
class ShopSuccessHomeDataStates extends ShopStates{}
class ShopErrorHomeDataStates extends ShopStates{}

class ShopSuccessCategoriesStates extends ShopStates{}
class ShopErrorCategoriesStates extends ShopStates{}

class ShopSuccessChangeFavoritesStates extends ShopStates{
  final ChangeFavoriteModel model;

  ShopSuccessChangeFavoritesStates(this.model);
}
class ShopErrorChangeFavoritesStates extends ShopStates{}
class ShopChangeFavoritesStates extends ShopStates{}

class ShopSuccessGetFavoritesStates extends ShopStates{}
class ShopErrorGetFavoritesStates extends ShopStates{}
class ShopLoadingGetFavoritesStates extends ShopStates{}

class ShopSuccessGetUserDataStates extends ShopStates{}
class ShopErrorGetUserDataStates extends ShopStates{}
class ShopLoadingGetUserDataStates extends ShopStates{}

class ShopSuccessUpdateUserDataStates extends ShopStates{}
class ShopErrorUpdateUserDataStates extends ShopStates{}
class ShopLoadingUpdateUserDataStates extends ShopStates{}
