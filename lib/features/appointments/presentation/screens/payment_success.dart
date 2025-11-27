import 'package:flutter/material.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/custom_botton.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: AlexText(text: "حالة العملية"),
        toolbarHeight: 70,
        leading: BackIcon(
            onTap:(){
              Navigator.pushReplacementNamed(context, Routes.homeScreen,);
            }
        ),
      ),
      body: Column(
        spacing: 20,
        children: [
          const Spacer(flex: 1,),
          AlexText(text: "العملية ناجحة ", fontSize: 20,),
        Image.asset('assets/images/success_payment.png', fit: BoxFit.cover,),
        const Spacer(flex: 2,),
        CustomButton(
            onPressed: (){
          Navigator.pushReplacementNamed(context, Routes.homeScreen,);
        },
          text: "الرجوع للرئيسية",
        ),
          const SizedBox.shrink(),
      ],)
    );

  }
}
