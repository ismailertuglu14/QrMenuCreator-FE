import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:qrmenu/core/extension/context_extension.dart';
import 'package:qrmenu/core/init/provider/reset_password_provider.dart';
import 'package:qrmenu/view/auth/resetpassword/widget/request_timeout_timer.dart';

import '../../../../core/constans/enum/reset_password_stepper_keys.dart';

import '../../../../product/utility/page_padding.dart';
import '../../../../product/widget/elevation_button.dart';
import '../../../../product/widget/outline_button.dart';
import 'otp_text_field.dart';

class ResetPasswordOtpStep extends StatefulWidget {
  const ResetPasswordOtpStep(
      {super.key,
      required this.checkEmail,
      required this.checkOtpCode,
      required this.otpCodeTextController,
      required this.resetTarget,
      required this.resetPasswordProvider,
      required this.pageController});
  final ResetPasswordProvider resetPasswordProvider;
  final Future<void> Function() checkEmail;
  final Future<void> Function() checkOtpCode;
  final TextEditingController otpCodeTextController;
  final PageController pageController;
  final String resetTarget;

  @override
  State<ResetPasswordOtpStep> createState() => _ResetPasswordOtpStepState();
}

class _ResetPasswordOtpStepState extends State<ResetPasswordOtpStep> {
  late final RequestTimeoutTimer _requestTimeoutTimer;
  @override
  void initState() {
    super.initState();

    _requestTimeoutTimer = const RequestTimeoutTimer(seconds: 60);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    "We send a vertification code to your registed email adress",
                    style: TextStyle(
                        fontSize: context.text.titleMedium?.fontSize)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () => widget.pageController.jumpToPage(
                            ResetPasswordStepperKeys.NEWPASSWORD.index),
                        child: Text.rich(
                          TextSpan(
                            text: "Change email ",
                            children: [
                              TextSpan(
                                  text: widget.resetTarget,
                                  style: TextStyle(
                                      color: context.colorScheme.primary)),
                            ],
                          ),
                        )))
              ],
            )),
        Expanded(
            flex: 2,
            child: OtpCodeTextField(controller: widget.otpCodeTextController)),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: PagePadding.allDefault(),
                  child: CommonOutlineButton(
                    onPressed: () async {
                      if (_requestTimeoutTimer.seconds.isEven) {
                        return await widget.checkEmail();
                      } else {
                        Fluttertoast.showToast(msg: "Please wait for timer");
                      }
                    },
                    child: Padding(
                      padding: const PagePadding.allLow(),
                      child: _requestTimeoutTimer,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: PagePadding.allDefault(),
                  child: CommonElevationButton(
                    child: const Padding(
                      padding: PagePadding.allMedium(),
                      child: Text("Done"),
                    ),
                    onPressed: () => widget.checkOtpCode(),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
