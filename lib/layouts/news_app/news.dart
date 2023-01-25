import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layouts/news_app/cubit/cubit.dart';
import 'package:my_app/layouts/news_app/cubit/states.dart';
import 'package:my_app/modules/search/search.dart';
import 'package:my_app/shared/components/components.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: (){
                cubit.changeAppMode();
              }, icon: Icon(Icons.dark_mode))
            ],
            title: Text('News App'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavState(index);
            },
          ),
          body: cubit.screen[cubit.currentIndex],
        );
      },
    );
  }
}
