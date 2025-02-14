import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service_locator.dart';
import '../../cubit/employee_cubit.dart';
import '../../pages/employee_list_page.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SplashCubit>()..appStarted(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is DisplayLoaded) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<EmployeeCubit>(
                  create: (context) => getIt<EmployeeCubit>(),
                  child: const EmployeeListPage(),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            double opacity = 0.1;

            if (state is DisplayLoading) {
              opacity = 1;
            }

            return Scaffold(
              backgroundColor: Colors.blue,
              body: Center(
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(seconds: 1),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
