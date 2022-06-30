import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_share/social_share.dart';

import '../../../notification/domain/repositories/notification_repository.dart';
import '../../../notification/infrastructure/repositories/notification_repository_impl.dart';
import '../../application/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  final NotificationRepository notificationRepository =
      NotificationRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    final secondrayColor = Theme.of(context).colorScheme.secondary;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Image.asset(
                  'assets/images/muhammad_peace_be_upon_him.png',
                ),
              ),
              TextButton(
                onPressed: () {
                  DatePicker.showTime12hPicker(
                    context,
                    locale: LocaleType.ar,
                    showTitleActions: true,
                    theme: DatePickerTheme(
                      doneStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                    ),
                    onConfirm: (date) async {
                      await notificationRepository.scheduleNotification(
                          time: date);

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString(
                        'notification_time',
                        date.toString(),
                      );
                    },
                    currentTime: DateTime.now(),
                  );
                },
                child: Text(
                  'وقت التنبيه اليومي',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'assets/images/muhammad_peace_be_upon_him.png',
            width: 66.25.w,
            height: 52.31.h,
          ),
          backgroundColor: const Color(0xFF0C262B).withOpacity(.2),
        ),
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/home_background.png',
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/images/quote.png',
                      width: 34.w,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, homeState) {
                      return homeState is HomeLoaded
                          ? SelectableText.rich(
                              TextSpan(
                                text: '${homeState.hadeeth!.almatn}.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 30.sp,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                children: [
                                  TextSpan(
                                    text: '\n${homeState.hadeeth!.source}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 20.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(.76),
                                          height: 3,
                                        ),
                                  ),
                                ],
                              ),
                              textDirection: TextDirection.rtl,
                            )
                          : CircularProgressIndicator(
                              color: secondrayColor,
                            );
                    },
                  ),
                  // SizedBox(
                  //   height: 15.h,
                  // ),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: RotatedBox(
                  //     quarterTurns: 2,
                  //     child: Image.asset(
                  //       'assets/images/quote.png',
                  //       width: 34.w,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Positioned(
              bottom: 80.h,
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, homeState) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      maximumSize: MaterialStateProperty.all(Size(178.w, 44.h)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        homeState is HomeLoaded
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.blueGrey,
                      ),
                      enableFeedback: homeState is HomeLoaded,
                    ),
                    child: Text(
                      'أنصر رسول الله ﷺ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15.sp,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    onPressed: () async {
                      if (homeState is HomeLoaded) {
                        final hashtags = homeState.hashtags!
                          ..sort(
                            (hashtag1, hashtag2) => hashtag1.priority.compareTo(
                              hashtag1.priority,
                            ),
                          );

                        List<String> hashtagsTexts =
                            hashtags.map((hashtag) => hashtag.text).toList();

                        await SocialShare.shareTwitter(
                          '''${homeState.hadeeth!.almatn}
                          ''',
                          hashtags: hashtagsTexts,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
