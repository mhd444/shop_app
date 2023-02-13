import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/shop_app/search_model.dart';
import 'package:my_app/modules/search/cubit/states.dart';
import 'package:my_app/shared/components/constants.dart';
import 'package:my_app/shared/network/end_points.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>{
  ShopSearchCubit() : super(InitialShopSearchState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void getSearch(String text)
  {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':text,
        },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}
