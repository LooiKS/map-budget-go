import 'package:flutter/material.dart';
import '../../widget/custom_shape.dart';

class TripsDetail extends StatefulWidget {
  @override
  _TripsDetailState createState() => _TripsDetailState();
}

class _TripsDetailState extends State<TripsDetail> {
  List<String> planTitle = ["KumKoiKum", "SuiMakMak"];
List<String> expensesTitle = ["Hotel","Transport"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trips to ocean"),
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                "Members",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            TripMemberList(),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Schedule",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text("View All",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.orange,
                        )),
                  ]),
            ),
            Container(
              height: 200.0,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext ctxt, int index) =>
                    buildPlansCard(ctxt, index),
                itemCount: planTitle.length,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Expenses",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text("View All",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.orange,
                        )),
                  ]),
            ),
            Container(
              height: 200.0,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext ctxt, int index) =>
                    buildExpensesCard(ctxt, index),
                itemCount: expensesTitle.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlansCard(BuildContext ctxt, int index) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: ListTile(
        selected: true,
        leading: Container(
          width: 48.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(
                  Icons.calendar_today,
                  size: 28.0,
                ),
                Text(
                  "Day ${index + 1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        // contentPadding: EdgeInsets.all(16.0),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30.0,
        ),
        title: Text(
          planTitle[index],
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        isThreeLine: true,
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "10a.m. - Depart to ocean.",
                style: TextStyle(),
              ),
              Text(
                "11a.m. - Eat beside ocean.",
                style: TextStyle(),
              ),
              Text(
                "12p.m. - Sleep beside ocean.",
                style: TextStyle(),
              ),
            ]),
        onTap: () {},
      ),
    );
  }

  Widget buildExpensesCard(BuildContext ctxt, int index) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: ListTile(
        selected: true,
        leading: Icon(Icons.hotel),
        // contentPadding: EdgeInsets.all(16.0),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30.0,
        ),
        title: Text(
          expensesTitle[index],
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        isThreeLine: true,
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Paid by Handsome",
                style: TextStyle(),
              ),
              Text(
                "02-02-2020 10:20 a.m.",
                style: TextStyle(),
              ),
              Text(
                "RM 200.00",
                style: TextStyle(),
              ),
            ]),
        onTap: () {},
      ),
    );
  }
}

class TripMemberList extends StatelessWidget {
  final Function(String) onTap;
  const TripMemberList({Key key, this.onTap}) : super(key: key);

  final List<String> members = const ["John", "Maria"];
  final List<String> image = const [
    "https://i.pinimg.com/736x/5a/0c/7b/5a0c7b76e2a8bcdbe571c5ba916f93fe.jpg",
    "https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: members.length + 1,
        itemBuilder: (context, index) {
          return index != members.length
              ? GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/loading.gif",
                          image: image[index],
                          fit: BoxFit.contain,
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        members[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {},
                  child: Column(children: <Widget>[
                    ClipOval(
                      child: Icon(
                        Icons.add_circle,
                        size: 40.0,
                        color: Colors.green,
                      ),
                    ),
                  ]),
                );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }
}
