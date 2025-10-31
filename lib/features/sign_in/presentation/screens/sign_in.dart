import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/helpers/secure_storage_helper.dart';
import 'package:lavender/core/helpers/show_floating_message.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/custom_botton.dart';
import 'package:lavender/features/sign_in/presentation/cubit/sign_in_cubit.dart';
import 'package:lavender/features/sign_in/presentation/cubit/sign_in_state.dart';
import 'package:lavender/features/sign_up/presentation/widgets/social_circle_button.dart';
import 'package:lavender/features/sign_up/presentation/widgets/text_fild.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: BlocConsumer<SignInCubit, SigninState>(
                  listener: (context, state) async {
                    if (state is SigninSuccess) {
                      final user = state.user;

                      showFloatingMessage(
                        context,
                        "تم تسجيل الدخول بنجاح 🎉",
                        background: AppColors.green1,
                        seconds: 2,
                      );

                        await SecureStorageHelper.saveTokens(
                          user.accessToken,
                          user.refreshToken,
                        );

                       /* showFloatingMessage(
                          context,
                          "تم تسجيل الدخول بنجاح 🎉",
                          background: AppColors.green1,
                          seconds: 2,
                        );*/

                        Navigator.pushReplacementNamed(context, Routes.homeScreen);
                    } else if (state is SigninError) {
                      showFloatingMessage(
                        context,
                        state.message,
                        background: Colors.red,
                        seconds: 2,
                      );
                    }
                  },
                  builder: (context, state) {
                    final cubit = context.read<SignInCubit>();
                    if (state is SigninLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "الرجوع",
                          style: TextStyle(
                            color: AppColors.purple600.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 35.h),
                      Center(
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            color: AppColors.primaryColorDarkText,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            title: 'البريد الإلكتروني',
                            hint: "البريد الإلكتروني",
                            controller: cubit.emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: 16.h),
                          CustomTextField(
                            title: 'كلمة المرور',
                            hint: "كلمة المرور",
                            controller: cubit.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                          ),
                          SizedBox(height: 30.h),
                          CustomButton(
                            text: "دخول",
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;

                              final email = cubit.emailController.text.trim();
                              final password = cubit.passwordController.text.trim();

                              context.read<SignInCubit>().signIn(
                                email: email,
                                password: password,
                              );
                            },
                            textColor: AppColors.w,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("ليس لديك حساب ؟"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.signUpScreen);
                                },
                                child: Text("إنشاء حساب"),
                              ),

                            ],
                          ),
                             Divider(
                               height: 1,
                               indent: 50,
                               endIndent: 50,
                               color: AppColors.grey100,
                             ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialCircleButton(
                                imagePath: 'assets/svg/icons_Facebook.svg',
                                onTap: () {},
                              ),

                              SocialCircleButton(
                                imagePath: 'assets/svg/icons.social_apple.svg',
                                onTap: () {},
                              ),

                              SocialCircleButton(
                                imagePath: 'assets/svg/icons.social_google.svg',
                                onTap: () {},
                              ),

                              SocialCircleButton(
                                imagePath: 'assets/svg/Group (2).svg',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
