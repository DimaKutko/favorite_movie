import 'package:favorite_movie/models/GlobalProvider.dart';
import 'package:favorite_movie/routes/navigatioBottom.dart';
import 'package:favorite_movie/service/favoriteMovieAdd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  Color pink = Color.fromRGBO(236, 37, 65, 1);
  Color grey = Color.fromRGBO(21, 21, 23, 1);

  bool viewed = false;
  final labelKey = GlobalKey<FormState>();
  String label;
  int priority = 1, rating = 1;

  Widget pickerPriority() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                'Priority:',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 5, left: 5),
                child: CupertinoPicker(
                  backgroundColor: Colors.black,
                  looping: true,
                  useMagnifier: true,
                  itemExtent: 30, //height of each item
                  scrollController: FixedExtentScrollController(initialItem: 1),
                  onSelectedItemChanged: (int index) {
                    int p = index;
                    setState(() {
                      priority = p;
                    });
                    print(priority);
                  },
                  children: <Widget>[
                    Center(
                      child: Text(
                        'High',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Medium',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Low',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pickerRating() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Rating:',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Center(
                child: CupertinoPicker(
                  backgroundColor: Colors.black,
                  itemExtent: 30, //height of each item
                  looping: true,
                  useMagnifier: true,
                  onSelectedItemChanged: (int index) {
                    int r = index;
                    setState(() {
                      rating = r + 1;
                    });
                    print(rating);
                  },
                  children: List<Widget>.generate(
                    10,
                    (int index) {
                      return Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    var movie = provider.getaddMovie;
    String title = movie.title,
        year = movie.year,
        poster = movie.poster,
        imdbid = movie.imdbid;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Top(),
          Expanded(
            child: Container(
                //color: Colors.white,
                child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 10,
                      ),
                      child: Container(
                        height: 296,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.34),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          image: DecorationImage(
                            image: NetworkImage('$poster'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(0, 0, 0, 0.2),
                                Color.fromRGBO(0, 0, 0, 0.2),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, top: 10),
                      child: Container(
                        height: 296,
                        width: 186,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '$title',
                                softWrap: true, //перенос строки
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: pink,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '($year)',
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: pink, width: 2),
                                  ),
                                  child: SwitchListTile(
                                    title: Text(
                                      'Viewed',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    value: viewed,
                                    inactiveTrackColor: Colors.white,
                                    activeColor: pink,
                                    onChanged: (bool value) {
                                      setState(() {
                                        viewed = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: pink, width: 2),
                    ),
                    child: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              'Label: ',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Form(
                              key: labelKey,
                              child: TextFormField(
                                cursorColor: Colors.white,
                                enableInteractiveSelection: false,
                                textInputAction:
                                    TextInputAction.done, //keyboard button type
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration.collapsed(
                                  border: InputBorder.none,
                                  hintText: null,
                                ),
                                onFieldSubmitted: (term) {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  });
                                },
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) return null;
                                },
                                onSaved: (value) {
                                  if (value != "") {
                                    label = value;
                                  } else {
                                    label = "pppqqqyyy";
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: 10, bottom: 10, top: 10, right: 5),
                        child: Container(
                          child: pickerPriority(),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: pink, width: 2),
                          ),
                        ),
                      )),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: 5, bottom: 10, top: 10, right: 10),
                        child: Container(
                          child: pickerRating(),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: pink, width: 2),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 15, bottom: 10, top: 5, right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: 40,
                      child: RaisedButton(
                        color: grey,
                        child: Text(
                          "Add",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: pink),
                        ),
                        onPressed: () {
                          labelKey.currentState.save(); //childhood
                          FavoriteAddMovie(
                            imdbid,
                            title,
                            year,
                            poster,
                            label,
                            priority,
                            viewed,
                            rating,
                          ).favoriteAddMovie();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 15, bottom: 10, right: 15, top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: 40,
                      child: RaisedButton(
                        color: grey,
                        child: Text(
                          "Exit",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: pink),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
