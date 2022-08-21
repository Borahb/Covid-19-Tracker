// ignore_for_file: camel_case_types, must_be_immutable
import 'package:covid19_tracker/Models/WorldStatesModel.dart';
import 'package:covid19_tracker/Screens/countries_list.dart';
import 'package:covid19_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';


class WorldStat_screen extends StatefulWidget {
  const WorldStat_screen({ Key? key }) : super(key: key);

  @override
  State<WorldStat_screen> createState() => _WorldStat_screenState();
}


class _WorldStat_screenState extends State<WorldStat_screen>with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3)
    )..repeat();






  @override

  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];




  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
          child: Column(
            children:[
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              // ignore: prefer_const_literals_to_create_immutables
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){

                  if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        )
                        );
                  }else{
                      return Column(
                        children: [
              PieChart(
                dataMap: {
                  "Total": double.parse(snapshot.data!.cases.toString()),
                  "Recovered": double.parse(snapshot.data!.recovered.toString()),
                  "Deaths": double.parse(snapshot.data!.deaths.toString())
              },
              animationDuration: const Duration(milliseconds: 1200),
              chartType: ChartType.ring,
              colorList: colorlist,
              chartRadius: MediaQuery.of(context).size.width /3.2,
              legendOptions: const LegendOptions(
                legendPosition: LegendPosition.left
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:25.0, left: 8.0, right: 8.0),
                child: Card(
                  child: Column(
                children: [
                    ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                    ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                    ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                    ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                    ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                    ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                    ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()), 
                  ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesList() ));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff1aa260),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const  Center(
                      child: Text('Track Countries'),
                    )
                  ),
                ),
              ),
              
                        ],
                      );
                  }
                }
                ),
              
             
            ]
          ),
        ),
      ),
    );
  }
}



class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({ Key? key, required this.title, required this.value }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right:10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],),
            const SizedBox(height: 5,),
            const Divider(),
        ],
      ),
    );
  }
}