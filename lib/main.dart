import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/employee_remote_data_source.dart';
import 'data/repositories/employee_repository_impl.dart';
import 'presentation/cubit/employee_cubit.dart';
import 'presentation/pages/employee_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Funcionários',
      home: BlocProvider(
        create: (context) => EmployeeCubit(
          repository: EmployeeRepositoryImpl(
            remoteDataSource: EmployeeRemoteDataSourceImpl(),
          ),
        )..fetchEmployees(),
        child: EmployeeListPage(),
      ),
    );
  }
}
