import 'package:flutter/material.dart';
import '../../utils/AppStrings.dart';
import 'widget/MatchProfileListWidget.dart';

///  MatchScreen - 프로필 스와이프 매칭 화면
///
///  주요 구성 요소:
///  - SwipeCardWidget: 프로필 카드를 스와이프할 수 있는 위젯
///  - SwipeButtonWidget: 수동으로 좌/우 스와이프를 할 수 있는 버튼

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.matchScreenTitle)),
      body: const Padding(
        padding: EdgeInsets.only(bottom: 36.0),
        child: Center(
          child: MatchProfileListWidget(),
        ),
      ),
    );
  }
}
