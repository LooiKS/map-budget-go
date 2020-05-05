import 'package:budgetgo/model/trips_class.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../main.dart';

class AddMember extends StatefulWidget {
  final Trips tripData;
  AddMember(this.tripData);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  List<User> _friendList = [];
  List<User> _selectedMember = [];
  @override
  void initState() {
    _friendList.addAll(widget.tripData.owner.friend);
    for (User friend in widget.tripData.owner.friend) {
      if (widget.tripData.members.contains(friend)) {
        setState(() {
          friend.isChecked = true;
        });
      } else {
        setState(() {
          friend.isChecked = false;
        });
      }
    }
    super.initState();
  }

  void filterSearchResults(String query) {
    List<User> dummySearchList = List<User>();
    dummySearchList.addAll(widget.tripData.owner.friend);
    if (query.isNotEmpty) {
      List<User> dummyListData = List<User>();
      dummySearchList.forEach((item) {
        if (item.username.contains(query)) {
          dummyListData.add(item);
        }
      });

      setState(() {
        _friendList.clear();
        _friendList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _friendList.clear();
        _friendList.addAll(widget.tripData.owner.friend);
      });
    }
  }

  void saveButton() {
    if (_selectedMember.length > 0) {
      setState(() {
        widget.tripData.members.addAll(_selectedMember);
      });
    }
    Navigator.of(context).pop(widget.tripData);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text(
              "Add Member",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            bottom: PreferredSize(
              preferredSize: Size(10.0, 55.0),
              child: TabBar(indicatorColor: Colors.purple, tabs: [
                Container(
                  height: 58.0,
                  child: Tab(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 35.0,
                          height: 35.0,
                          margin: EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color:
                                  key.currentState.brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.transparent,
                              image: DecorationImage(
                                image: ExactAssetImage(
                                    'assets/images/contact_book.png'),
                                fit: BoxFit.contain,
                              )),
                        ),
                        Text(
                          "Friend List",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 58.0,
                  child: Tab(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 35.0,
                          height: 35.0,
                          margin: EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color:
                                  key.currentState.brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.transparent,
                              image: DecorationImage(
                                image:
                                    ExactAssetImage('assets/images/qrcode.png'),
                                fit: BoxFit.contain,
                              )),
                        ),
                        Text(
                          "QR Code",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 58.0,
                  child: Tab(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 35.0,
                          height: 35.0,
                          margin: EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color:
                                  key.currentState.brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.transparent,
                              image: DecorationImage(
                                image: ExactAssetImage(
                                    'assets/images/search_icon.png'),
                                fit: BoxFit.contain,
                              )),
                        ),
                        Text(
                          "ID/Phone No.",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            elevation: 0,
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 6.0, left: 7, right: 7, bottom: 0),
                      child: TextField(
                        onChanged: (value) => filterSearchResults(value),
                        decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                        ),
                      ),
                    ),
                    _selectedMember.length > 0
                        ? Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Selected: ${_selectedMember.length}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ButtonBar(
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 10.0,
                                      height: 28.0,
                                      child: RaisedButton(
                                        onPressed: () => saveButton(),
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    ButtonTheme(
                                      minWidth: 10.0,
                                      height: 28.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(null);
                                        },
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text("Cancel",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(0.0),
                          ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ListTile(
                              leading: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  fadeInCurve: Curves.bounceIn,
                                  placeholder: "assets/images/loading.gif",
                                  image: _friendList[index].profilePic,
                                  fit: BoxFit.contain,
                                  width: 40.0,
                                  height: 40.0,
                                ),
                              ),
                              title: Row(
                                children: <Widget>[
                                  Text(_friendList[index].username),
                                ],
                              ),
                              trailing: widget.tripData.owner.friend[index]
                                          .isChecked &&
                                      widget.tripData.members.contains(
                                          widget.tripData.owner.friend[index])
                                  ? Checkbox(
                                      onChanged: null,
                                      value: widget.tripData.owner.friend[index]
                                          .isChecked,
                                    )
                                  : Checkbox(
                                      value: _friendList[index].isChecked,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        setState(() {
                                          _friendList[index].isChecked = value;
                                          if (value == true) {
                                            _selectedMember.add(widget
                                                .tripData.owner.friend[index]);
                                          } else {
                                            _selectedMember.remove(widget
                                                .tripData.owner.friend[index]);
                                          }
                                        });
                                      },
                                    )),
                          itemCount: _friendList.length),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text(
                        "Total Friend: ${_friendList.length}",
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.pink,
                child: Center(child: Text("Call Tab")),
              ),
              Container(
                color: Colors.blue,
                child: Center(child: Text("Call Tab")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
