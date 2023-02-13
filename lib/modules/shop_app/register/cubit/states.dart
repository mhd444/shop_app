import 'package:my_app/models/shop_app/login_model.dart';

import '../../../../models/shop_app/register_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialStates extends ShopRegisterStates{}

class ShopRegisterLoadingStates extends ShopRegisterStates{}

class ShopRegisterSuccessStates extends ShopRegisterStates{
  final ShopRegisterModel registerModel;

  ShopRegisterSuccessStates(this.registerModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates{
  final String error;

  ShopRegisterErrorStates(this.error);
}

class ShopRegisterChangeIconStates extends ShopRegisterStates{}