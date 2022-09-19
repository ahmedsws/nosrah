import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nosrah/features/ansar_magazine/application/bloc/ansar_magazine_issues_bloc.dart';
import 'package:nosrah/features/ansar_magazine/presentation/pages/ansar_magazine_PDF_page.dart';
import 'package:url_launcher/url_launcher.dart';

class AnsarMagazinePage extends StatelessWidget {
  const AnsarMagazinePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnsarMagazineIssuesBloc()..add(GetAnsarMagazineIssues()),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Image.asset(
              'assets/images/muhammad_peace_be_upon_him.png',
              width: 66.25.w,
              height: 52.31.h,
            ),
            backgroundColor: const Color(0xFF0C262B),
          ),
          body: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/home_background.png',
                fit: BoxFit.fill,
              ),
              BlocBuilder<AnsarMagazineIssuesBloc, AnsarMagazineIssuesState>(
                builder: (context, issuesState) {
                  return issuesState is AnsarMagazineIssuesLoaded
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 45.h),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      'أعداد مجلة أنصار النبي ﷺ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'وهي مجلة دورية تصدرها الهيئة العالمية لنصرة نبي الإسلام',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(.8),
                                          fontSize: 16.sp,
                                        ),
                                  ),
                                  SizedBox(height: 35.h),
                                  ...issuesState.ansarMagazineIssues!
                                      .map(
                                        (magazineIssue) => TextButton(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .withOpacity(.75),
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.h),
                                            child: Text(
                                              'العدد ${magazineIssue.issueNumber}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(.7),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AnsarMagazinePDFPage(
                                                  ansarMagazineIssue:
                                                      magazineIssue,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
              // Positioned(
              //   bottom: 30.h,
              //   left: 16.w,
              //   child: TextButton(
              //     style: ButtonStyle(
              //       maximumSize: MaterialStateProperty.all(Size(178.w, 44.h)),
              //       shape: MaterialStateProperty.all(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15.r),
              //         ),
              //       ),
              //     ),
              //     child: Text(
              //       'موقع المجلة',
              //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //             fontSize: 16.sp,
              //             color: Theme.of(context).colorScheme.secondary,
              //             decoration: TextDecoration.underline,
              //             decorationColor:
              //                 Theme.of(context).colorScheme.secondary,
              //             decorationThickness: 2,
              //             fontWeight: FontWeight.bold,
              //           ),
              //     ),
              //     onPressed: () async {
              //       const url = 'http://www.ansarmag.com/';
              //       if (!await launchUrl(Uri.parse(url))) {
              //         throw 'Could not launch $url';
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
