import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/GetApiCovid.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:untitled1/component/color.dart';


class LineChartPageAlt extends StatefulWidget {


  @override
  _LineChartPageState createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPageAlt> {

  final typeReport = ['kasus', 'sembuh', 'meninggal'];


  List data = [];
  void getDataChartCovid(){
    GetDataApiCovid.getData().then((value){
      setState(() {
        data = value;
      });
    });
  }


  @override
  void initState() {

    getDataChartCovid();
    // TODO: implement initState
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: GetDataApiCovid.getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            return ListView(
              padding: const EdgeInsets.all(9),

              children: [
                Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.89,
                        height: 260,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          color: MyColor().colorBlue,
                          child: Stack(
                            children: [
                              LineChart(
                                  LineChartData(
                                    minX: 1,
                                    maxX: 7,
                                    minY: 0,
                                    maxY: 10,
                                    // lineTouchData: LineTouchData(
                                    //   enabled: true,
                                    //   getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                                    //     return spotIndexes.map((index) {
                                    //       return TouchedSpotIndicatorData(
                                    //         FlLine(
                                    //           color: Colors.pink,
                                    //         ),
                                    //         FlDotData(
                                    //           show: true,
                                    //           getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                    //             radius: 8,
                                    //             strokeWidth: 2,
                                    //             strokeColor: Colors.white,
                                    //           ),
                                    //         ),
                                    //       );
                                    //     }).toList();
                                    //   },
                                    //   touchTooltipData: LineTouchTooltipData(
                                    //     tooltipBgColor: Colors.pink,
                                    //     tooltipRoundedRadius: 8,
                                    //     getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                                    //       return lineBarsSpot.map((lineBarSpot) {
                                    //         return LineTooltipItem(
                                    //           lineBarSpot.y.toString(),
                                    //           const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    //         );
                                    //       }).toList();
                                    //     },
                                    //   ),
                                    // ),


                                    lineTouchData: LineTouchData(
                                        touchTooltipData: LineTouchTooltipData(
                                            maxContentWidth: 100,
                                            tooltipBgColor: Colors.white,
                                            getTooltipItems: (List<LineBarSpot> touchedBarSpots){
                                              return touchedBarSpots.map((barSpot){
                                                const data =['kasus', 'sembuh', ['meninggal']];
                                                final flSpot = barSpot;
                                                print(barSpot.y);
                                                final textStyle = TextStyle(
                                                  color: barSpot.bar.colors[0],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                );

                                                return LineTooltipItem(
                                                    '${(barSpot.y*100).toStringAsFixed(0)} ${'orang'}\n', textStyle);
                                              }).toList();
                                            }
                                        )
                                    ),





                                    lineBarsData: [
                                      LineChartBarData(
                                          spots: [
                                            for (var i = (data.length-7); i < data.length; i++)...[
                                              FlSpot((i + 1) - (data.length-7).toDouble(), data[i].kasus.toDouble()/100)
                                            ],
                                          ],
                                          barWidth: 3,
                                          colors: [
                                            Color.fromRGBO(251, 24, 24, 1)
                                          ]

                                      ),

                                    ],
                                    titlesData: FlTitlesData(
                                      show: true,
                                      leftTitles: SideTitles(
                                          showTitles: true,
                                          margin: 8,
                                          reservedSize: 38,
                                          getTextStyles: (value) => const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 7,
                                          ),
                                          getTitles: (value){
                                            switch (value.toInt()){
                                              case 0:
                                                return '';
                                              case 2:
                                                return '200';
                                              case 4:
                                                return '400';
                                              case 6:
                                                return '600';
                                              case 8:
                                                return '800';
                                              case 10:
                                                return '1000';
                                            }
                                            return '';
                                          }
                                      ),
                                      bottomTitles: SideTitles(
                                          showTitles: true,
                                          margin: 8,
                                          reservedSize: 30,
                                          getTextStyles: (value) => const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 5.7,
                                          ),
                                          getTitles: (value){
                                            DateFormat formatter = DateFormat('yyyy-MM-dd');

                                            // return formatter.format(data[data.length - 7].tanggal);
                                            switch (value.toInt()){
                                              case 1:
                                                return formatter.format(data[data.length - 7].tanggal);
                                              case 2:
                                                return formatter.format(data[data.length - 6].tanggal);
                                              case 3:
                                                return formatter.format(data[data.length - 5].tanggal);
                                              case 4:
                                                return formatter.format(data[data.length - 4].tanggal);
                                              case 5:
                                                return formatter.format(data[data.length - 3].tanggal);
                                              case 6:
                                                return formatter.format(data[data.length - 2].tanggal);
                                              case 7:
                                                return formatter.format(data[data.length - 1].tanggal);
                                            }
                                            return '';
                                          }
                                      ),
                                      rightTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 30,
                                          getTitles: (value){
                                            switch (value.toInt()){
                                              case 15:
                                                return '';
                                              case 20:
                                                return '';
                                              case 13:
                                                return '';
                                            }
                                            return '';
                                          }
                                      ),
                                      topTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 20,
                                          getTitles: (value){
                                            switch (value.toInt()){
                                              case 15:
                                                return '';
                                              case 20:
                                                return '';
                                              case 13:
                                                return '';
                                            }
                                            return '';
                                          }
                                      ),
                                    ),

                                    gridData: FlGridData(
                                        show: true,
                                        getDrawingHorizontalLine: (value){
                                          return FlLine(
                                            color: Color.fromRGBO(102, 117, 127, 0.7),
                                            strokeWidth: 1,
                                          );
                                        },
                                        drawVerticalLine: false,
                                        getDrawingVerticalLine: (value){
                                          return FlLine(
                                            color: Color.fromRGBO(102, 117, 127, 1),
                                            strokeWidth: 1,
                                          );
                                        }
                                    ),
                                  )
                              ),

                            ]
                          ),
                        ),
                      ),
                    ]
                  ),
                ),


              ],

            );
          }
          else{
            return ListView(
              padding: const EdgeInsets.all(9),
              children: [
                Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width*0.89,
                      color: MyColor().colorBlueGrey,
                      child: Center(
                          child:
                          CircularProgressIndicator()
                      )
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
