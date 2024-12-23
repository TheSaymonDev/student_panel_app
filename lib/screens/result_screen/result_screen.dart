import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:student_panel/utils/app_colors.dart';
import 'package:student_panel/utils/app_urls.dart';
import 'package:student_panel/widgets/custom_elevated_btn.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.outOf,
  });

  final int score;
  final int outOf;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _controller = ConfettiController();
  var result = 'A+';
  final AudioPlayer _passedPlayer = AudioPlayer();
  final AudioPlayer _failedPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double outOf = (40 / 100) * widget.outOf.toDouble();
    if (widget.score >= outOf) {
      _controller.play();
      _playPassedMusic();
    } else {
      _controller.stop();
      _playFailedMusic();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorizeColors = [
    Colors.white,
    Colors.lightBlueAccent,
    Colors.yellow,
    Colors.lightGreenAccent,
  ];

  @override
  Widget build(BuildContext context) {
    double outOf = (40 / 100) * widget.outOf.toDouble();
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          backgroundColor: AppColors.primaryClr,
          body: SafeArea(
            child: Column(
              children: [
                Gap(32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                          widget.score >= outOf
                              ? 'অভিনন্দন আপনি পরীক্ষায়\nপাস করেছেন'
                              : 'আপনি পরীক্ষায় ভালো করতে পারেন নি, পুনরায় চেষ্টা করুন',
                          textStyle: Theme.of(context).textTheme.titleLarge!,
                          colors: colorizeColors,
                          textAlign: TextAlign.center),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
                Gap(16.h),
                SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .20,
                    child: widget.score >= outOf
                        ? Lottie.asset(AppUrls.passedAnim)
                        : Lottie.asset(AppUrls.failedAnim)),
                const Spacer(),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 25.h, horizontal: 15.w),
                      padding: EdgeInsets.symmetric(
                          vertical: 45.h, horizontal: 20.w),
                      height: MediaQuery.of(context).size.height * .22,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: AppColors.primaryClr),
                              child: Text(
                                '${widget.score}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Colors.yellow, fontSize: 50.sp),
                              ),
                            ),
                          ),
                          Gap(16.w),
                          Text(
                            ':',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white, fontSize: 50.sp),
                          ),
                          Gap(16.w),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: AppColors.primaryClr),
                              child: Text(
                                '${widget.outOf}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Colors.white, fontSize: 50.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        right: 120,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 12.h),
                          decoration: BoxDecoration(
                              color: AppColors.primaryClr,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.r),
                                  bottomRight: Radius.circular(10.r))),
                          child: Text(
                            "Final Score",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        )),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomElevatedBtn(
                    onPressed: () {},
                    name: 'Submit',
                    height: 60.h,
                  ),
                ),
                Gap(32.h),
              ],
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: _controller,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
        )
      ],
    );
  }

  Future<void> _playPassedMusic() async {
    await _passedPlayer.setAudioSource(AudioSource.asset(AppUrls.passedSound));
    await _passedPlayer.play();
  }

  Future<void> _playFailedMusic() async {
    await _failedPlayer.setAudioSource(AudioSource.asset(AppUrls.failedSound));
    await _failedPlayer.play();
  }
}
