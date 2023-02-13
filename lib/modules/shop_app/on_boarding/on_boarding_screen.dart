import 'package:flutter/material.dart';
import 'package:my_app/modules/shop_app/login/login_screen.dart';
import 'package:my_app/shared/network/local/cash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   var boardController = PageController();

  List<BoardingModel> boarding =[
    BoardingModel(
        image: "assets/images/on_board1.jpg",
        title: "on Board 1 title",
        body: "on Board 1 body",),
    BoardingModel(
      image: "assets/images/on_board2.jpg",
      title: "on Board 2 title",
      body: "on Board 2 body",),
    BoardingModel(
      image: "assets/images/on_board3.jpg",
      title: "on Board 3 title",
      body: "on Board 3 body",),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
                  navigateAndFinish(
                      context,
                      ShopLoginScreen());
                });
              },
              child: Text('SKIP'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index == boarding.length - 1)
                    {
                      setState(() {
                        isLast = true;
                      });
                    } else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                    controller: boardController,
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        navigateAndFinish(context,ShopLoginScreen());
                      }
                      else{
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }

                    },
                  child: Icon(Icons.arrow_forward),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Text('${model.title}',style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
      ),),
      const SizedBox(
        height: 15,
      ),
      Text('${model.body}',style: const TextStyle(
        fontSize: 15,

      ),)
    ],
  );
}
