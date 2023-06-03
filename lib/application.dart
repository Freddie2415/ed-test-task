import 'package:flutter/material.dart';

import 'presentation/pages/main_page.dart';
import 'presentation/theme/app_colors.dart';
import 'presentation/theme/app_text_styles.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Task Application',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: AppBarTheme(
          titleTextStyle: AppTextStyles.title,
          backgroundColor: AppColors.gray,
        ),
      ),
      home: const MainPage(),
    );
  }
}
