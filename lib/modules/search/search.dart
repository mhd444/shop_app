import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layouts/news_app/cubit/cubit.dart';
import 'package:my_app/layouts/news_app/cubit/states.dart';
import 'package:my_app/shared/components/components.dart';
class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return  Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  cursorColor: Colors.red,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepOrange
                      )
                    ),
                    prefixIcon: Icon(Icons.search,color: Colors.deepOrange,),
                    label: Text('Search',style: TextStyle(
                      color: Colors.deepOrange
                    ),),
                  ),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "Search must not empty";
                    } else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
             Expanded(
               child: ListView.separated(
                   itemBuilder: (context,index) => buildArticleItem(list[index],context),
                   separatorBuilder: (context,index) => myDivider(),
                   itemCount: list.length),
             )
            ],
          ),
        );
      },
    ) ;
  }
}
