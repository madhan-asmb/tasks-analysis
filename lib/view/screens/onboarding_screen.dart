import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'home_page.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color blackColor = Colors.black;
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'A reader lives a thousand lives',
            body: 'The man who never reads lives only one.',
            image: buildImage('assets/img1.jpg'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Featured Books',
            body: 'Available right at your fingerprints',
            image: buildImage('assets/img1.jpg'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Simple UI',
            body: 'For enhanced reading experience',
            image: buildImage('assets/img2.jpg'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Today a reader, tomorrow a leader',
            body: 'Start your journey',
            image: buildImage('assets/img3.jpg'),
            decoration: getPageDecoration(),
          ),
        ],
        done: Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () => goToHome(context),
        doneColor: blackColor,
        showSkipButton: true,
        skip: Text('Skip'),
        onSkip: () => goToHome(context),
        skipColor: blackColor,
        next: Icon(Icons.arrow_forward),
        nextColor: blackColor,
        dotsDecorator: getDotDecoration(),
        // onChange: (index) => print('Page $index selected'),
        globalBackgroundColor: Colors.white,
        skipFlex: 0,
        nextFlex: 0,
      ),
    );
  }

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
