import 'package:covid_app/Model/world_states_model.dart';
import 'package:covid_app/View/countries_list.dart';
import 'package:covid_app/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices state = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              FutureBuilder(
                future: state.fetchWorkStatesRecord(),
                builder: (context ,AsyncSnapshot<WorldStatesModel> snapshot){
                if(!snapshot.hasData){
                  return Expanded(flex: 1, child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50,
                    controller: _controller,
                  ),);
                }else{
                    return Column(
                      children: [

              PieChart(
                dataMap:  {
                  "total": double.parse(snapshot.data!.cases!.toString()),
                  "Recoverd": double.parse(snapshot.data!.recovered!.toString()),
                  "Death": double.parse(snapshot.data!.deaths!.toString()),
                },
                chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                legendOptions:
                    const LegendOptions(legendPosition: LegendPosition.left),
                animationDuration: Duration(milliseconds: 1200),
                chartType: ChartType.ring,
                colorList: colorList,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.06),
                child: Card(
                  child: Column(
                    children: [
                      ReusableRow(
                        title: 'total',
                        value: snapshot.data!.cases!.toString(),
                      ),
                       ReusableRow(
                        title: 'Death',
                        value: snapshot.data!.deaths!.toString(),
                      ),
                       ReusableRow(
                        title: 'Recovered',
                        value: snapshot.data!.recovered!.toString(),
                      ),
                       ReusableRow(
                        title: 'Active',
                        value: snapshot.data!.active!.toString(),
                      ),
                      ReusableRow(
                        title: 'Critical',
                        value: snapshot.data!.critical!.toString(),
                      ),
                      ReusableRow(
                        title: 'Today Death',
                        value: snapshot.data!.todayDeaths!.toString(),
                      ),
                      ReusableRow(
                        title: 'Today Recovered',
                        value: snapshot.data!.todayRecovered!.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()),);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)
                  ),
                  child: Center(child: Text('Track Countries')),
                ),
              )
           
                      ],
                    );
                }

              }), ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
