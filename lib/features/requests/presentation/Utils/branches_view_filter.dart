import 'package:bankease/features/requests/domain/entities/branch.dart';

extension BranchesViewFilter on Iterable<Branch> {
  Iterable<Branch> filter(String contains) {
    return where((branch) =>
        branch.toString().toLowerCase().contains(contains.toLowerCase()));
  }
}
