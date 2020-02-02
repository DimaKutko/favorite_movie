import 'package:favorite_movie/service/getrecomended.dart';
import 'package:favorite_movie/service/movielist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:favorite_movie/routes/route.dart';
import 'dart:convert';



class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index1 = 1, index2 = 2, index3 = 3;
  String rposter;


  var _listmovie;
  getListMovie() async {
    final listmovie = await ListMovie().getFavoriteMovie();
    final _recomended = await RecomendedIml().getrecomended();
    _listmovie = listmovie;
    rposter = jsonDecode(jsonEncode(_recomended.poster));

    setState(() {});
  }

  @override
  void initState() {
    getListMovie();

    super.initState();
  }

  Widget _buildData() {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        controller: new ScrollController(keepScrollOffset: false),
        childAspectRatio: 0.67, // size, standart = 1.0
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${_listmovie[index1].poster}'),
                  fit: BoxFit.fill,
                ),
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${_listmovie[index2].poster}'),
                  fit: BoxFit.fill,
                ),
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${_listmovie[index3].poster}'),
                  fit: BoxFit.fill,
                ),
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('$rposter'),
                  fit: BoxFit.fill,
                ),
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(43, 44, 47, 1),
      body: Column(
        children: <Widget>[
          Top(),
          Expanded(
            child: Container(
              child: Center(
                child: _buildData(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: NavigationBotom(),
          ),
        ],
      ),
    );
  }
}
