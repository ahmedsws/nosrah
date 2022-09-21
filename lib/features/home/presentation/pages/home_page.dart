import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nosrah/features/home/presentation/widgets/menu_widget.dart';
import 'package:social_share/social_share.dart';
import '../../application/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  final String prophetSaid = 'قال رسول الله ﷺ: ';

  @override
  Widget build(BuildContext context) {
    final secondrayColor = Theme.of(context).colorScheme.secondary;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: MenuWidget(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'assets/images/muhammad_peace_be_upon_him.png',
            width: 50.25.w,
            height: 37.31.h,
          ),
          backgroundColor: const Color(0xFF163036),
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
                    child: Text(
                      prophetSaid,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 20.sp,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.76),
                            height: 3,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
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
                                text: '${homeState.hadeeth!.almatn}\n',
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
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width - 50, 50.h),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
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
                            fontSize: 16.sp,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    onPressed: () async {
                      if (homeState is HomeLoaded) {
                        String tweetText =
                            prophetSaid + homeState.hadeeth!.almatn;

                        final hashtags = homeState.hashtags!
                          ..sort(
                            (hashtag1, hashtag2) => hashtag1.priority.compareTo(
                              hashtag1.priority,
                            ),
                          );

                        final List<String> hashtagsTexts = [];
                        hashtags.forEach(
                          (hashtag) {
                            // 4 is the count of characters(" + " +  + #) in the tweet
                            if (tweetText.length + hashtag.text.length + 4 <=
                                280) {
                              tweetText += '#${hashtag.text}';

                              hashtagsTexts.add(hashtag.text);
                            }
                          },
                        );

                        // TODO: share on facebook
                        await SocialShare.shareTwitter(
                          '''$prophetSaid"${homeState.hadeeth!.almatn}"''',
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
