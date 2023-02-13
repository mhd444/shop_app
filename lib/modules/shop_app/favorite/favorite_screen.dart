import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/shop_app/favotites_model.dart';

import '../../../layouts/shop_app/cubit/cubit.dart';
import '../../../layouts/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesStates,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildListProductItem(
                  cubit.favoritesModel!.data.data[index].product, context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.favoritesModel!.data.data.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildListProductItem(model, context) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.red,
                      child: Text(
                        'Discount',
                        style: TextStyle(color: Colors.white, fontSize: 8.0),
                      ),
                    )
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.0,
                            height: 1.3,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0)
                          Text(
                            model.oldPrice.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10.0,
                                height: 1.3,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.id);
// print(model.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopCubit.get(context)
                                .favorites[model.id]!
                                ? defaultColor
                                : Colors.grey,
                            radius: 15.0,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
