import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qrmenu/core/extension/asset_image_extension.dart';
import 'package:qrmenu/core/extension/context_extension.dart';
import 'package:qrmenu/core/extension/router_extension.dart';
import 'package:qrmenu/product/widget/close_keyboard.dart';

import '../../../../core/constans/enum/image_keys.dart';

import '../../../../core/constans/enum/reset_password_stepper_keys.dart';
import '../../../../core/constans/enum/reset_password_type_keys.dart';
import '../../../../core/constans/enum/route_keys.dart';
import '../../../../core/init/network/network_manager.dart';
import '../../../../core/init/provider/reset_password_provider.dart';
import '../../../../product/utility/border_radius.dart';
import '../../../../product/utility/durations.dart';
import '../../../../product/utility/page_padding.dart';
import '../../../../product/widget/app_bar.dart';
import '../../login/view/login_view.dart';
import '../model/reset_password_check_email_request_model.dart';
import '../model/reset_password_check_email_response_model.dart';
import '../model/reset_password_check_otp_code_request_model.dart';
import '../model/reset_password_check_otp_code_response_model.dart';
import '../model/reset_password_request_model.dart';
import '../model/reset_password_response_model.dart';
import '../service/ResetPassword_service.dart';
import '../widget/reset_password_otp_step.dart';
import '../widget/reset_password_submit_change_step.dart';
import '../widget/reset_password_type_step.dart';

part '../viewmodel/reset_password_view_model.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ResetPasswordViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CommonAppBar(),
        body: CloseKeyboard(
          child: SingleChildScrollView(
            child: SizedBox(
              height: context.height,
              width: context.width,
              child: Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                      width: context.width,
                      height: context.height * 0.28,
                      child: CustomPaint(
                        painter: AppBarPainter(),
                        child: Padding(
                          padding: PagePadding.allHeight(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.qr_code_rounded,
                                  size: context.width * 0.2,
                                  color: Colors.white70),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Reset Password",
                                      style: context.text.headlineMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                  Text("Reset your password",
                                      style: TextStyle(color: Colors.white70))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const PagePadding.spesificAuth(),
                    child: Column(
                      children: [
                        Spacer(flex: 3),
                        Expanded(
                            flex: 7,
                            child: PageView.custom(
                                controller: _pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                childrenDelegate:
                                    SliverChildListDelegate.fixed([
                                  ResetPasswordTypeStep(
                                      resetTargetTextController:
                                          _resetTargetTextController,
                                      checkEmail: checkEmail),
                                  ResetPasswordOtpStep(
                                      pageController: _pageController,
                                      resetTarget:
                                          _resetTargetTextController.text,
                                      otpCodeTextController:
                                          _otpCodeTextController,
                                      checkOtpCode: checkOtpCode,
                                      resetPasswordProvider:
                                          _resetPasswordProvider,
                                      checkEmail: checkEmail),
                                  ResetPasswordSubmitChangeStep(
                                    passwordConfirmTextController:
                                        _passwordConfirmTextController,
                                    passwordTextController:
                                        _passwordTextController,
                                    resetPassword: resetPassword,
                                  )
                                ]))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
