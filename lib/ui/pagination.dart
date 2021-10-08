import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_issues/network_utils/http_client.dart';
import 'package:flutter_issues/response_model/issues.dart';
import 'package:pagination_view/pagination_view.dart';
import 'dart:async';
import 'dart:convert';
import 'flutter_issues_details.dart';
import 'package:flutter_issues/bloc/pagination_bloc.dart';
class Pagination extends StatelessWidget {

  var page = 1;
  Map queryParam = {
    "per_page": "10",
  };
  var textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xff371D32),
      fontFamily: 'SFProDisplayRegular',
      fontWeight: FontWeight.normal);

  void _modalBottomSheetMenu(BuildContext context,String data) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        context: context,
        builder: (_) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xffF68E65),
                                fontWeight: FontWeight.normal,
                                fontFamily: 'SFProDisplayRegular',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(width: 100),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Sort by',
                              style: TextStyle(
                                  color: Color(0xff371D32),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto'),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          queryParam["sort"] = "created";
                          queryParam["direction"] = "desc";
                          page = 1;
                          paginationKey.currentState.refresh();
                          paginationBloc.changedSortBy.call('Newest');
                          Navigator.pop(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Newest',
                              style: textStyle,
                            ),
                            data == 'Newest'?  Icon(Icons.check, color: Colors.deepOrangeAccent):Container(),
                          ],
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          queryParam["sort"] = "created";
                          queryParam["direction"] = "asc";
                          page = 1;
                          paginationKey.currentState.refresh();
                          paginationBloc.changedSortBy.call('Oldest');
                          Navigator.pop(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Oldest',
                              style: textStyle,
                            ),
                           data== 'Oldest'?  Icon(Icons.check, color: Colors.deepOrangeAccent):Container(),
                          ],
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          queryParam["sort"] = "comments";
                          queryParam["direction"] = "desc";
                          page = 1;
                          paginationKey.currentState.refresh();
                          paginationBloc.changedSortBy.call('Most commented');
                          Navigator.pop(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Most commented',
                              style: textStyle,
                            ),
                            data== 'Most commented'?  Icon(Icons.check, color: Colors.deepOrangeAccent):Container(),
                          ],
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          queryParam["sort"] = "created";
                          queryParam["direction"] = "asc";
                          page = 1;
                          paginationKey.currentState.refresh();
                          paginationBloc.changedSortBy.call('Least commented');
                          Navigator.pop(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Least commented',
                              style: textStyle,
                            ),
                            data== 'Least commented'?  Icon(Icons.check, color: Colors.deepOrangeAccent):Container(),
                          ],
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          queryParam["sort"] = "updated";
                          queryParam["direction"] = "desc";
                          page = 1;
                          paginationKey.currentState.refresh();
                          paginationBloc.changedSortBy.call('Recently updated');
                          Navigator.pop(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recently updated',
                              style: textStyle,
                            ),
                            data== 'Recently updated'?  Icon(Icons.check, color: Colors.deepOrangeAccent):Container(),
                          ],
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          queryParam["sort"] = "updated";
                          queryParam["direction"] = "asc";
                          page = 1;
                          paginationKey.currentState.refresh();
                          paginationBloc.changedSortBy.call('Least Recently updated');
                          Navigator.pop(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Least Recently updated',
                              style: textStyle,
                            ),
                            data== 'Least Recently updated'?  Icon(Icons.check, color: Colors.deepOrangeAccent):Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _stateModalBottomSheetMenu(BuildContext context,String data) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        context: context,
        builder: (_) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xffF68E65),
                                fontWeight: FontWeight.normal,
                                fontFamily: 'SFProDisplayRegular',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(width: 100),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'State',
                              style: TextStyle(
                                  color: Color(0xff371D32),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto'),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          queryParam["state"] = "open";
                          page = 1;
                          paginationKey.currentState.refresh();
                          paginationBloc.changedState.call('Open Issues');
                          Navigator.pop(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Open Issues',
                              style: textStyle,
                            ),
                            data== 'Open Issues'?  Icon(Icons.check, color: Colors.deepOrangeAccent):Container(),
                          ],
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          queryParam["state"] = "closed";
                          page = 1;
                          paginationKey.currentState.refresh();
                          paginationBloc.changedState.call('Closed Issues');
                          Navigator.pop(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Closed Issues',
                              style: textStyle,
                            ),
                            data== 'Closed Issues'?  Icon(Icons.check, color: Colors.deepOrangeAccent):Container(),
                          ],
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          queryParam["state"] = "all";
                          page = 1;
                          paginationKey.currentState.refresh();
                          paginationBloc.changedState.call('All Issues');
                          Navigator.pop(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All Issues',
                              style: textStyle,
                            ),
                            data== 'All Issues'?  Icon(Icons.check, color: Colors.deepOrangeAccent):Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  GlobalKey<PaginationViewState> paginationKey = GlobalKey<PaginationViewState>();
  PaginationBloc paginationBloc ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .08,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, left: 10, right: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    color: Color(0xffF2F2F2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () {
                      AdaptiveTheme.of(context).toggleThemeMode();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Toggle Theme',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff371D32),
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<String>(
                    stream: paginationBloc.state,
                    builder: (context, stateSnapshot) {
                      return RaisedButton(
                        color: Color(0xffF2F2F2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        onPressed: () {
                          _stateModalBottomSheetMenu(context,stateSnapshot.data);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'State',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff371D32),
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.4),
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.sort,
                              color: Color(0xff371D32),
                              size: 20,
                            )
                          ],
                        ),
                      );
                    }
                  ),
                  StreamBuilder<String>(
                    stream: paginationBloc.sortBy,
                    builder: (context, sortBySnapshot) {
                      return sortBySnapshot.hasData?RaisedButton(
                        color: Color(0xffF2F2F2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        onPressed: () {
                          _modalBottomSheetMenu(context,sortBySnapshot.data);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'SORT BY',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff371D32),
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.4),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.sort,
                              color: Color(0xff371D32),
                              size: 20,
                            )
                          ],
                        ),
                      ):Container();
                    }
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).accentColor,
            thickness: 1,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .77,
            child: PaginationView<Issue>(
              key: paginationKey,
              itemBuilder: (BuildContext context, Issue issue, int index) =>
                  InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/issueDetails',
                      arguments: issue);
                },
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: Theme.of(context).accentColor,
                        size: 20,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          issue.title,
                        ),
                      ),
                      subtitle: issue.user != null && issue.user.login != null
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '#${issue.number}',
                                ),
                                Text(
                                  ' by ${issue.user.login}',
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    Divider(
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              paginationViewType: PaginationViewType.listView,
              pageFetch: pageFetch,
              pageRefresh: pageFetch,
              bottomLoader: Center(
                // optional
                child: CircularProgressIndicator(),
              ),
              initialLoader: Center(
                // optional
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Issue>> pageFetch(int currentListSize) {
    queryParam['page'] = page++;
    var queryString = '?';
    for (var key in queryParam.keys) {
      if (queryParam[key] != null && queryParam[key] != "") {
        queryString += '$key=${queryParam[key]}&';
      }
    }
    var completer = Completer<List<Issue>>();
    HttpClient.get(
            'https://api.github.com/repos/flutter/flutter/issues${queryString.substring(0, queryString.length - 1)}')
        .then((response) {
      List<Issue> result = List();
      for (int index = 0; index < response.length; index++) {
        result.add(Issue.fromJson(response[index]));
      }
      completer.complete(result);
    });
    return completer.future;
  }

  Pagination(){
    this.paginationBloc = PaginationBloc();
    paginationBloc.changedSortBy.call("Newest");
    paginationBloc.changedState.call("Open Issues");
  }
}
