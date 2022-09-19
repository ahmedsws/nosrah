import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../features/home/application/bloc/home_bloc.dart';
import '../../../features/home/presentation/pages/home_page.dart';

class AppBase extends StatelessWidget {
  const AppBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.tajawalTextTheme(),
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
            secondary: Color(0xFF239B70),
          ),
        ),
        home: BlocProvider(
          create: (context) => HomeBloc()..add(GetHomeData()),
          child: HomePage(),
        ),
      ),
    );
  }
}
