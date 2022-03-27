import 'package:covid19/view/world_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DetalScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases ,totalDeaths, totalRecovered, active, cricatal, todayRecoverde, test;

   DetalScreen({
     required this.image,
     required this.name,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.cricatal,
     required this.todayRecoverde,
     required this.test,
     });

  @override
  State<DetalScreen> createState() => _DetalScreenState();
}

class _DetalScreenState extends State<DetalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [

                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06,),
                        ReusableleRow(title: 'Cases', value: widget.totalCases.toString(),),
                        ReusableleRow(title: 'Recovered', value:  widget.totalRecovered.toString(),),
                        ReusableleRow(title: 'Death', value:  widget.totalDeaths.toString(),),
                        ReusableleRow(title: 'Critical', value: widget.cricatal.toString(),),
                        ReusableleRow(title: 'Today Recovered', value:widget.totalRecovered.toString(),),

                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
      
    );
  }
}