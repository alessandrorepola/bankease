import 'package:bankease/features/requests/domain/entities/request.dart';

enum RequestsViewFilter { all, pendingOnly, completedOnly }

extension RequestsViewFilterX on RequestsViewFilter {
  bool apply(Request request) {
    switch (this) {
      case RequestsViewFilter.all:
        return true;
      case RequestsViewFilter.pendingOnly:
        return request.status == Status.pending;
      case RequestsViewFilter.completedOnly:
        return request.status == Status.complete;
    }
  }

  Iterable<Request> applyAll(Iterable<Request> requests) {
    return requests.where(apply);
  }
}
