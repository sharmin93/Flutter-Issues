import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_issues/issues.dart';
import 'package:flutter_issues/network_utils/http_client.dart';
import 'package:flutter_issues/response_model/pagination_ui_model.dart';
import 'package:pagination_view/pagination_view.dart';
import 'dart:async';
import 'dart:convert';

import 'Bloc/pagination_bloc.dart';
import 'flutter_issues_details.dart';
class Pagination extends StatelessWidget{

  var page=1;
  Map queryParam={"per_page":"30",};
  var textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xff371D32),
      fontFamily: 'SFProDisplayRegular',
      fontWeight: FontWeight.normal);

  void _modalBottomSheetMenu(BuildContext context) {
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

                      InkWell(onTap: (){
                        queryParam["sort"]="created";
                        queryParam["direction"]="desc";
                        page =1;
                        paginationKey.currentState.refresh();
                        Navigator.pop(context);
                      },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Newest',
                              style: textStyle,
                            ),
                            Icon(Icons.check, color: Color(0xff371D32)),

                          ],
                        ),
                      ),
                      Divider(),

                      InkWell(onTap: (){
                        queryParam["sort"]="created";
                        queryParam["direction"]="asc";
                        page =1;
                        paginationKey.currentState.refresh();
                        Navigator.pop(context);
                      },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Oldest',
                              style: textStyle,
                            ),
                            Icon(Icons.check, color: Color(0xff371D32)),
                          ],
                        ),
                      ),
                      Divider(),
                      // Nearest to farthest
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Most commented',
                            style: textStyle,
                          ),
                          Icon(Icons.check, color: Color(0xff371D32)),
                        ],
                      ),
                      Divider(),
                      //most recent//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Least commented',
                            style: textStyle,
                          ),
                          Icon(Icons.check, color: Color(0xff371D32)),
                        ],
                      ),
                      Divider(),

                      //vehicle make//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Recently updated',
                            style: textStyle,
                          ),
                          Icon(Icons.check, color: Color(0xff371D32)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Least Recently updated',
                            style: textStyle,
                          ),
                          Icon(Icons.check, color: Color(0xff371D32)),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  GlobalKey<PaginationViewState> paginationKey =  GlobalKey<PaginationViewState>();
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.08,
            child: Padding(
              padding: const EdgeInsets.only(top: 12,left: 10,right: 10,bottom: 10),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
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
                          'Set Theme',
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
                  RaisedButton(
                    color: Color(0xffF2F2F2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () {
                      _modalBottomSheetMenu(context);
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
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Theme.of(context).accentColor,thickness: 1,),
          Container(height: MediaQuery.of(context).size.height*.77,
            child:
            PaginationView<Issue>(
              key: paginationKey,
              itemBuilder: (BuildContext context, Issue issue, int index) => InkWell(onTap: (){
               Navigator.pushNamed(context, '/issueDetails',arguments: issue);
              },
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.circle,color: Theme.of(context).accentColor,size: 20,),
                      title:Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(issue.title,),
                      ),
                      subtitle: issue.user!=null &&issue.user.login!=null?
                      Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('#${issue.number}',),
                          Text(' by ${issue.user.login}',),
                        ],
                      ):Container(),
                    ),
                    Divider(color: Colors.grey,)
                  ],
                ),
              ),
              paginationViewType: PaginationViewType.listView,
              pageFetch: pageFetch,
              pageRefresh: pageFetch,
              bottomLoader: Center( // optional
                child: CircularProgressIndicator(),
              ),
              initialLoader: Center( // optional
                child: CircularProgressIndicator(),
              ),
            ),

          ),
        ],
      ),
    );
  }


  Future<List<Issue>> pageFetch(int currentListSize) {
    queryParam['page'] =page++;
    var queryString = '?';
    for(var key in queryParam.keys){
      if (queryParam[key]!= null && queryParam[key]!="") {
        queryString += '$key=${queryParam[key]}&';
      }
    }
    var completer = Completer<List<Issue>>();
    HttpClient.get('https://api.github.com/repos/flutter/flutter/issues${queryString.substring(0, queryString.length-1)}').
    then((response) {
      List<Issue> result = List();
      for (int index = 0; index < response.length; index++) {
        result.add(Issue.fromJson(response[index]));
      }
      completer.complete(result);
    });
    return completer.future;
  }
}
