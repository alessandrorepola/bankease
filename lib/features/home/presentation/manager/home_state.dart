part of 'home_cubit.dart';

enum HomeTab { requests, account }

final class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.requests,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
