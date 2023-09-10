// import 'package:bankease/core/injection.dart';
// import 'package:bankease/core/use_case/use_case.dart';
// import 'package:bankease/features/requests/data/repositories/requests_repo_impl.dart';
// import 'package:bankease/features/requests/domain/entities/request.dart';
// import 'package:bankease/features/requests/domain/use_cases/load_requests_use_case.dart';
// import 'package:bankease/features/requests/presentation/manager/requests_bloc/requests_bloc.dart';
// import 'package:riverpod/riverpod.dart';

// final requestsProvider =
//     StateNotifierProvider<RequestsList, RequestsState>((ref) {
//   return RequestsList(LoadRequestsUseCase(
//     Injection.getIt.get<RequestsRepoImpl>(),
//   ));
// });

// class RequestsList extends StateNotifier<RequestsState> {
//   final LoadRequestsUseCase loadRequestsUseCase;

//   RequestsList(this.loadRequestsUseCase) : super(RequestsInitial()) {
//     loadRequests();
//   }

//   loadRequests() async {
//     state = RequestsLoadInProgress();
//     final result = loadRequestsUseCase.call(NoParams());
//     state = result.;
//   }

//   List<Request> get requests => (super.state as RequestsLoadSuccess).equests;

//   RequestsLoadSuccess get RequestsLoadSuccessState =>
//       (super.state as RequestsLoadSuccess);

//   unBookMarkRequest(Request Request) {
//     final index = Requests.indexWhere((element) => element.id == Request.id);
//     final newRequests = RequestsLoadSuccessState.Requests;
//     newRequests[index] = newRequests[index].copyWith(isBookmarked: false);
//     state = RequestsLoadSuccessState.copyWith(Requests: newRequests);
//   }

//   pickRequestImage() async {
//     final result = await pickRequestImageUseCase.call(NoParams());
//   }
// }
