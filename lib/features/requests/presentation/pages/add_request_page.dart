import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/presentation/manager/branches_bloc/branches_bloc.dart';
import 'package:bankease/features/requests/presentation/manager/cities_cubit.dart/cities_cubit.dart';
import 'package:bankease/features/requests/presentation/widgets/branch_fields.dart';
import 'package:flutter/material.dart';
import 'package:bankease/features/requests/presentation/manager/add_request/add_request_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddRequestPage extends ConsumerWidget {
  AddRequestPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(addRequestProvider);
    final notifier = ref.read(addRequestProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Book Service Request'),
        centerTitle: true,
        actions: [
          IconButton(
            key: UniqueKey(),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                notifier.addRequest();
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50.0,
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1.0, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      icon: const Icon(Icons.arrow_drop_down),
                      validator: (value) {
                        if (value == null) {
                          return "Select Service";
                        } else {
                          return null;
                        }
                      },
                      iconSize: 28,
                      hint: const Text("Select Service"),
                      isExpanded: true,
                      value: state.service,
                      onChanged: (value) {
                        if (value != null) {
                          notifier.onChangedService(value);
                        }
                      },
                      items: Service.values.map((valueItem) {
                        return DropdownMenuItem(
                            value: valueItem.name, child: Text(valueItem.name));
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const Divider(height: 10),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<BranchesBloc>(
                        create: (context) => BranchesBloc(),
                      ),
                      BlocProvider<CitiesCubit>(
                        create: (context) => CitiesCubit(),
                      ),
                    ],
                    child: const BranchFields(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
