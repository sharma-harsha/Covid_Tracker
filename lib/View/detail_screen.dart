import 'package:covid_app/View/world_state.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalcases,
      totalDeath,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      tests;
  DetailScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.totalcases,
      required this.totalDeath,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.tests});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      ReusableRow(
                          title: 'cases', value: widget.totalcases.toString()),
                      ReusableRow(
                          title: 'totalRecovered', value: widget.totalRecovered.toString()),
                      ReusableRow(
                          title: 'totalDeath', value: widget.totalDeath.toString()),
                      ReusableRow(
                          title: 'active', value: widget.active.toString()),
                      ReusableRow(
                          title: 'tests', value: widget.tests.toString()),
                      ReusableRow(
                          title: 'critical', value: widget.critical.toString()),
                      ReusableRow(
                          title: 'todayRecovered', value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xffF4C430),
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          )
        ],
      ),
    );
  }
}
