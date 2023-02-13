import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/modules/search/cubit/cubit.dart';
import 'package:my_app/modules/search/cubit/states.dart';
import '../../../models/shop_app/search_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKeys = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKeys,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: searchController,
                        decoration: InputDecoration(
                            label: Text('Search'),
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 1.0,
                                    color: Colors.grey,
                                    style: BorderStyle.solid))),
                        validator: (String? valid) {
                          if (valid!.isEmpty) {
                            return "Please enter text to search";
                          }
                        },
                        onFieldSubmitted: (String txt) {
                          ShopSearchCubit.get(context).getSearch(txt);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      if (state is ShopSearchLoadingState)
                        LinearProgressIndicator(),
                      if (state is ShopSearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildSearchItem(
                                    ShopSearchCubit.get(context)
                                        .searchModel!
                                        .data
                                        .data[index],
                                    context,
                                  ),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: ShopSearchCubit.get(context)
                                  .searchModel!
                                  .data
                                  .data
                                  .length),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget buildSearchItem(Product model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 120.0,
                height: 120.0,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
