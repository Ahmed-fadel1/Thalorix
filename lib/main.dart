import 'package:flutter/material.dart';
import 'package:thalorix_app/core/utils/router/app_router.dart';

void main() {
  final AppRouter myRouter = AppRouter();
  runApp(Thalorix(appRouter: myRouter));
}

class Thalorix extends StatelessWidget {
  final AppRouter appRouter;
  const Thalorix({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
