import 'package:covid19/services/state_services.dart';
import 'package:covid19/view/detal_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountrisListScreen extends StatefulWidget {
  const CountrisListScreen({Key? key}) : super(key: key);

  @override
  State<CountrisListScreen> createState() => _CountrisListScreenState();
}

class _CountrisListScreenState extends State<CountrisListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Search with country name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                suffixIcon: searchController.text.isEmpty
                    ? const Icon(Icons.search)
                    : GestureDetector(
                        onTap: () {
                          searchController.text = "";
                          setState(() {});
                        },
                        child: Icon(Icons.clear)),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
           Expanded(
              child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>>  snapshot){
                    print(snapshot);
                if(!snapshot.hasData){
                 return ListView.builder(
                   itemCount: 4,
                   itemBuilder: (context, index){
                     return Shimmer.fromColors(
                       baseColor: Colors.grey.shade700,
                       highlightColor: Colors.grey.shade100,
                       enabled: true,
                       child: Column(
                         children: [
                           ListTile(
                             leading:  Container(height: 50 , width: 50, color: Colors.white,),
                             title:  Container(
                               width: 100,
                               height: 8.0,
                               color: Colors.white,
                             ),
                             subtitle:  Container(
                               width: double.infinity,
                               height: 8.0,
                               color: Colors.white,
                             ),
                           ),

                         ],
                       ),
                     );
                   },

                  );
                }else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        String name = snapshot.data![index]['country'];
                        if(searchController.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetalScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'] ,
                                    totalCases:  snapshot.data![index]['cases'] ,
                                    totalRecovered: snapshot.data![index]['recovered'] ,
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecoverde: snapshot.data![index]['todayRecovered'],
                                    cricatal: snapshot.data![index]['critical'] ,
                                  )));
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                  title: Text(snapshot.data![index]['country']) ,
                                  subtitle:  Text("Effected: "+ snapshot.data![index]['cases'].toString()) ,
                                ),
                              ),
                              Divider()
                            ],
                          );

                        }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetalScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'] ,
                                    totalCases:  snapshot.data![index]['cases'] ,
                                    totalRecovered: snapshot.data![index]['recovered'] ,
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecoverde: snapshot.data![index]['todayRecovered'],
                                    cricatal: snapshot.data![index]['critical'] ,
                                  )));
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                  title: Text(snapshot.data![index]['country']) ,
                                  subtitle:  Text("Effected: "+ snapshot.data![index]['cases'].toString()) ,
                                ),
                              ),
                              Divider()
                            ],
                          );
                        }else {
                          return Container();
                        }
                      }
                  );
                }
              }),
            )
          
        ],
      )),
    );
  }
}
