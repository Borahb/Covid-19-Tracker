// ignore_for_file: must_be_immutable

import 'package:covid19_tracker/Screens/world_stats.dart';
import 'package:flutter/material.dart';



class Detail extends StatefulWidget {
  
  String image;
  String name;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
   Detail({ Key? key, 
   required this.image,
   required this.name, 
   required this.totalCases,
   required this.totalDeaths,
   required this.totalRecovered, 
   required this.active, 
   required this.critical, 
   required this.todayRecovered, 
   required this.test }): 
   super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
              children:[
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height:MediaQuery.of(context).size.height * 0.067,),
                        ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                        ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                        ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                        ReusableRow(title: 'Active', value: widget.active.toString()),
                        ReusableRow(title: 'Critical', value: widget.critical.toString()),
                        ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                        ReusableRow(title: 'Tests', value: widget.test.toString()),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top:MediaQuery.of(context).size.height * 0.0006,
                  child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(widget.image),
                          ),
                )
              ],
          ),
        ],
      )
    );
  }
}