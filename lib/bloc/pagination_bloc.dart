import 'package:flutter_issues/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PaginationBloc implements BaseBloc{
  final _sortByController= BehaviorSubject<String>();
  Function(String) get changedSortBy => _sortByController.sink.add;
  Stream<String> get sortBy => _sortByController.stream;

  final _stateController= BehaviorSubject<String>();
  Function(String) get changedState => _stateController.sink.add;
  Stream<String> get state => _stateController.stream;

  @override
  void dispose() {
    _sortByController.close();
    _stateController.close();
  }

}
