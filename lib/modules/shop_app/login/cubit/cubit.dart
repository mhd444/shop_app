import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/shop_app/login_model.dart';
import 'package:my_app/modules/shop_app/login/cubit/states.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';
import '../../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
      url: LOGIN,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel!.message);
      emit(ShopLoginSuccessStates(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  bool isPassword = false;
  IconData suffix = Icons.visibility;

  void changeIcon() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopLoginChangeIconStates());
  }
}
