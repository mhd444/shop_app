import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layouts/news_app/cubit/cubit.dart';
import 'package:my_app/layouts/news_app/cubit/states.dart';
import 'package:my_app/layouts/shop_app/cubit/cubit.dart';
import 'package:my_app/shared/components/constants.dart';
import 'package:my_app/shared/network/local/cash_helper.dart';
import 'package:my_app/shared/network/remote/dio_helper.dart';
import 'package:my_app/shared/styles/themes.dart';
import 'layouts/shop_app/shop_layout.dart';
import 'modules/shop_app/login/login_screen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getData(key: 'isDark');
  late Widget widget;
  bool onBoarding = CashHelper.getData(key: 'onBoarding');
  token = CashHelper.getData(key: 'token');
  print(token);
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    onBoarding: onBoarding,
    isDark: isDark,
    startWidget: widget,
  ));
}

//non
class MyApp extends StatelessWidget {
  MyApp(
      {Key? key,
      required this.isDark,
      required this.startWidget,
      required this.onBoarding})
      : super(key: key);
  final bool? isDark;
  final Widget startWidget;
  final bool onBoarding;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavorites()..getUserData()
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: LayoutBuilder(builder: (BuildContext , BoxConstraints ) {
              return startWidget;
            },
            ),
            themeMode: cubit.isDark ? ThemeMode.light : ThemeMode.dark,
          );
        },
      ),
    );
  }
}
