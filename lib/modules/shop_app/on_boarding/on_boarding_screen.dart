import 'package:first_pro/modules/shop_app/login/shop_login_screen.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:first_pro/shared/network/local/cache_helper.dart';
import 'package:first_pro/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/on_boarding_1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/on_boarding_1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/on_boarding_1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  bool isLast = false;

void submit(){
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'SKIP',
              style: TextStyle(color: defaultColor, fontSize: 15.0,),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print('Last');
                  } else {
                    setState(() {
                      isLast = false;
                    });
                    print('Not Last');
                  }
                },
                itemBuilder:
                    (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  backgroundColor: defaultColor,
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image: AssetImage('${model.image}'), fit: BoxFit.fill),
      ),
      Text(
        '${model.title}',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 5.0),
      Text(
        '${model.body}',
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 10.0),
    ],
  );
}
