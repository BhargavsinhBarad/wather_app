import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:wather_app/Model/Utils/api.dart';

import '../Model/Utils/api_model.dart';
import '../Provider/platefrom.dart';
import '../Provider/theme_provider.dart';

class home_Screen extends StatefulWidget {
  const home_Screen({super.key});

  @override
  State<home_Screen> createState() => _home_ScreenState();
}

class _home_ScreenState extends State<home_Screen> {
  String titl = "Surat";

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (
        BuildContext context,
        AsyncSnapshot<ConnectivityResult> snapshot,
      ) {
        return (snapshot.data == ConnectivityResult.mobile ||
                snapshot.data == ConnectivityResult.wifi)
            ? Scaffold(
                body: FutureBuilder(
                    future: api_helper.api.getdata(search: titl),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        api_model? apimodel = snapshot.data;
                        return Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage((Provider.of<
                                                          themeprovider>(
                                                      context,
                                                      listen: true)
                                                  .theme
                                                  .isdark ==
                                              true)
                                          ? "https://i.pinimg.com/736x/7f/63/1e/7f631e577ed5e5ffbbce726f8ec03489.jpg"
                                          : "https://w0.peakpx.com/wallpaper/654/512/HD-wallpaper-moon-clouds-full-moon-nature-sky-weather.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                SearchBarAnimation(
                                  searchBoxColour: Colors.black,
                                  buttonColour: Colors.black,
                                  buttonWidget: Icon(
                                    Icons.search_rounded,
                                    color: Colors.white,
                                  ),
                                  secondaryButtonWidget: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  textEditingController: textEditingController,
                                  isOriginalAnimation: true,
                                  trailingWidget: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  onFieldSubmitted: (String value) {
                                    setState(() {
                                      titl = value;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_sharp,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "${apimodel?.location['name']}, ${apimodel?.location['country']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Provider.of<themeprovider>(
                                                      context,
                                                      listen: false)
                                                  .changetheme();
                                            },
                                            icon: Icon(
                                              Icons.bedtime_sharp,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Switch(
                                              // activeColor: Colors.black,
                                              inactiveTrackColor: Colors.black,
                                              value: Provider.of<platfrom>(
                                                      context,
                                                      listen: false)
                                                  .isios,
                                              onChanged: (val) {
                                                Provider.of<platfrom>(context,
                                                        listen: false)
                                                    .changeolatfrom(val);
                                              }),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Text(
                                          "Today, ${apimodel?.forecast['forecastday'][0]['date']}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 130,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Text(
                                          "${apimodel?.current['temp_c']}℃",
                                          style: TextStyle(
                                            fontSize: 35,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Feelslike",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                                Text("℃",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white)),
                                                Text(
                                                    "${apimodel?.current['feelslike_c']}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Wind",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                                Icon(
                                                  Icons.air,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                    "${apimodel?.current['wind_kph']}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Cloud",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                                Icon(
                                                  Icons.cloud,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                    "${apimodel?.current['cloud']}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Humidity",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                                Icon(
                                                  Icons.water_drop,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                    "${apimodel?.current['humidity']}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: 24,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              Container(
                                            height: 100,
                                            width: 100,
                                            margin: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "${index}:00",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                                Image.network(
                                                    "http:${apimodel?.forecast['forecastday'][0]['hour'][index]['condition']['icon']}"),
                                                Text(
                                                    "${apimodel?.forecast['forecastday'][0]['hour'][index]['temp_c']}℃",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: Container(
                          height: 400,
                          width: 400,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://cdn.dribbble.com/users/205136/screenshots/2582152/ae-fun.gif"),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    }),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Container(
                    height: 450,
                    width: 500,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("lib/Assets/1.gif"),
                            fit: BoxFit.cover)),
                  ),
                ),
              );
      },
    );
  }
}
