import 'package:flutter_issues/Bloc/base_bloc.dart';
import 'package:flutter_issues/response_model/pagination_ui_model.dart';
import 'package:rxdart/subjects.dart';


class Bloc extends  Object  implements BaseBloc{
    final _homePageController = BehaviorSubject<PaginationUiModel>();

  Function(PaginationUiModel) get changedHomePage => _homePageController.sink.add;
 Stream<PaginationUiModel> get homePage=> _homePageController.stream;
  @override
  void dispose() {
    _homePageController?.close();
  }

}