import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/domain/use_cases/get_filtered_branches_use_case.dart';
import 'package:flutter/material.dart';
import 'package:bankease/features/requests/presentation/manager/add_request/add_request_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddRequestDialog extends ConsumerWidget {
  AddRequestDialog({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _branchController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(addRequestProvider);
    final notifier = ref.read(addRequestProvider.notifier);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Padding(
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
                  Container(
                    height: 50.0,
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1.0, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TypeAheadFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: _branchController,
                          decoration:
                              const InputDecoration(hintText: 'Type a Branch')),
                      suggestionsCallback: (pattern) async {
                        return await GetFilteredBranchesUseCase().call(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.toString()),
                        );
                      },
                      transitionBuilder: (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      onSuggestionSelected: (suggestion) {
                        _branchController.text = suggestion.toString();
                        notifier.onChangedBranch(suggestion.id);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a branch';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100.h),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel')),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            notifier.addRequest();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Save')),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
