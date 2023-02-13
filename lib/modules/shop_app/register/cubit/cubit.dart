import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/modules/shop_app/register/cubit/states.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';
import '../../../../models/shop_app/register_model.dart';
import '../../../../shared/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopRegisterModel? registerModel;

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(
      url: REGISTER,
      data: {
        "email": email,
        "password": password,
        "phone":phone,
        "name":name,
      },
    ).then((value) {
      print(value.data);
      registerModel = ShopRegisterModel.fromJson(value.data);
      print(registerModel!.message);
      emit(ShopRegisterSuccessStates(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorStates(error.toString()));
    });
  }

  bool isPassword = false;
  IconData suffix = Icons.visibility;

  void changeIcon() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopRegisterChangeIconStates());
  }
}
