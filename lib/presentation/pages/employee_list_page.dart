import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/employee_cubit.dart';
import '../cubit/expansion_cubit.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  String formatPhoneNumber(String phone) {
    return phone.replaceAllMapped(
      RegExp(r'^(\d{2})(\d{2})(\d{5})(\d{4})$'),
      (Match m) => '+${m[1]} (${m[2]}) ${m[3]}-${m[4]}',
    );
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Row(
          children: [
            SizedBox(
              width: 16,
            ),
            CircleAvatar(
              child: Text('CG'),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(
                  Icons.notification_add_outlined,
                  color: Colors.black,
                  size: 34,
                ),
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blue,
                    child: Text(
                      '02',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Funcionários',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Pesquisar',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(80),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (query) {
                      context.read<EmployeeCubit>().filterEmployees(query);
                    },
                  ),
                  SizedBox(height: 16),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      leading: Text(
                        "Foto",
                        style: TextStyle(fontSize: 16),
                      ),
                      title: Text(
                        "Nome",
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Icon(Icons.circle),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.employees.length,
                      itemBuilder: (context, index) {
                        final employee = state.employees[index];
                        return BlocProvider(
                          create: (context) => ExpansionCubit(),
                          child: BlocBuilder<ExpansionCubit, bool>(
                            builder: (context, isExpanded) {
                              return Column(
                                children: [
                                  Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    margin: EdgeInsets.zero,
                                    child: ExpansionTile(
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(employee.image),
                                      ),
                                      title: Text(employee.name),
                                      trailing: Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: Colors.blue,
                                      ),
                                      onExpansionChanged: (expanded) {
                                        context
                                            .read<ExpansionCubit>()
                                            .toggleExpansion();
                                      },
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Cargo'),
                                                  Text(employee.job),
                                                ],
                                              ),
                                              Divider(),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Data de admissão'),
                                                  Text(
                                                    formatDate(
                                                        employee.admissionDate),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Telefone'),
                                                  Text(
                                                    formatPhoneNumber(
                                                        employee.phone),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is EmployeeError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Nenhum dado disponível'));
        },
      ),
    );
  }
}
