import 'package:covid_app/View/detail_screen.dart';
import 'package:covid_app/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  StatesServices countries = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // title: ,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search with country name ',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: countries.CountriesListApi(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];

                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                                image: snapshot.data![index]['countryInfo']['flag'],
                                                name: snapshot.data![index]['country'],
                                                totalcases: snapshot.data![index]['cases'],
                                                totalRecovered: snapshot.data![index]['recovered'],
                                                totalDeath: snapshot.data![index]['deaths'],
                                                active: snapshot.data![index]['active'],
                                                tests: snapshot.data![index]['texts'],
                                                critical: snapshot.data![index]['critical'],
                                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                              )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: CircleAvatar(
                                    backgroundColor: Color(0xffF4C430),
                                    foregroundImage: NetworkImage(snapshot
                                        .data![index]['countryInfo']['flag']),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (name.toLowerCase().contains(
                              searchController.text.toLowerCase(),
                            )) {
                          return Column(
                            children: [
                              InkWell(
                                 onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                                image: snapshot.data![index]['countryInfo']['flag'],
                                                name: snapshot.data![index]['country'],
                                                totalcases: snapshot.data![index]['cases'],
                                                totalRecovered: snapshot.data![index]['recovered'],
                                                totalDeath: snapshot.data![index]['deaths'],
                                                active: snapshot.data![index]['active'],
                                                tests: snapshot.data![index]['texts'],
                                                critical: snapshot.data![index]['critical'],
                                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                              )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                  leading: CircleAvatar(
                                    backgroundColor: Color(0xffF4C430),
                                    foregroundImage: NetworkImage(snapshot
                                        .data![index]['countryInfo']['flag']),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
