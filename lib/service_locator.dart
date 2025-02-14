import 'package:get_it/get_it.dart';
import '../data/datasources/employee_remote_data_source.dart';
import '../data/repositories/employee_repository_impl.dart';
import '../presentation/cubit/employee_cubit.dart';
import '../presentation/splash/cubit/splash_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Registra o EmployeeRemoteDataSource
  getIt.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(),
  );

  // Registra o EmployeeRepositoryImpl
  getIt.registerLazySingleton<EmployeeRepositoryImpl>(
    () => EmployeeRepositoryImpl(
      remoteDataSource: getIt<EmployeeRemoteDataSource>(),
    ),
  );

  // Registra o EmployeeCubit
  getIt.registerFactory<EmployeeCubit>(
    () => EmployeeCubit(
      repository: getIt<EmployeeRepositoryImpl>(),
    )..fetchEmployees(),
  );

  // Registra o SplashCubit
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(),
  );
}
