import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layouts/shop_app/cubit/cubit.dart';
import 'package:my_app/models/shop_app/categories_model.dart';
import 'package:my_app/models/shop_app/home_model.dart';
import 'package:my_app/shared/styles/colors.dart';

import '../../../layouts/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesStates){
          if(!state.model.status){
            showToast(
                text: state.model.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) =>
              productBuilder(cubit.homeModel!, cubit.categoriesModel!, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                viewportFraction: 1.0,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoriesItem(
                            categoriesModel.data.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10.0,
                            ),
                        itemCount: categoriesModel.data.data.length),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.8,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(model.data.products.length,
                    (index) => buildGridProduct(model.data.products[index],context)),
              ),
            )
          ],
        ),
      );

  Widget buildCategoriesItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            fit: BoxFit.cover,
            height: 100.0,
            width: 100.0,
          ),
          Container(
              width: 100.0,
              color: Colors.black.withOpacity(.8),
              child: Text(
                model.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              )),
        ],
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
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
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
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
                          '${model.oldPrice.round()}',
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
                          ShopCubit.get(context).changeFavorites(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                          radius: 15.0,
                            child: Icon(Icons.favorite_border,
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
      );
}
