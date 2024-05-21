import 'package:device_track/_manager/generalLayout/generalLayoutCtr.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../_manager/bindings.dart';
import '../_manager/styles.dart';
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
);

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutCtr>(
      builder: (context) {
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final String startDate = formatter.format(layCtr.startDate!);
        final String endDate = formatter.format(layCtr.endDate!);


        return Container(
          color: bgCol,

          child:   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              children: [
                SizedBox(height: 30,),
                  //
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: Center(
                  //     child: Text(
                  //       'Duration:  ${ (layCtr.startDate != null && layCtr.endDate != null)?  ' ${startDate} to ${endDate}' : 'not selected'}',
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         color: transparentTextCol,
                  //         fontSize: 18
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Device: ${layCtr.selectedDevice.device.name}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: normalTextCol,
                        fontSize: 25
                      ),
                    ),
                  ),
                /// CHART *******************************



                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Expanded(
                    child: SizedBox(
                      height: 30.h,
                      width: 100.w,
                      child: LineChart(

                        LineChartData(
                          minX: 0,
                          maxX: 14,
                          minY: 0,
                          maxY: 100,
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(

                                showTitles: true,
                                interval: 20,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}',style: TextStyle(color: primaryColor),);
                                },

                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}s',style: TextStyle(color: primaryColor),);
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            horizontalInterval: 20,
                            verticalInterval: 1,
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: layCtr.selectedDevice.flSpots,
                              //spots: layCtr.generateRandomSpots(15, 80.0),
                              isCurved: true,
                              color: primaryColor,
                              barWidth: 3,
                              belowBarData: BarAreaData(show: false),
                              dotData: FlDotData(show: false),

                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'Graph de Consomation de Carbone',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 17,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),

                /// **********************************************
                //co2
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cout CO2',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: normalTextCol,

                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${layCtr.selectedDevice.money} TND',
                            style: TextStyle(
                              fontSize: 16,
                              color: transparentTextCol,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Image.asset(
                          'assets/images/money.png',
                          width: 50, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                        ),
                      ),
                    ],
                  ),
                )  ,   //
                SizedBox(height: 10),
// co2
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '0.000s',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: normalTextCol,

                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.trending_down_sharp,
                                color: Colors.green,),
                              Text(
                                '${layCtr.selectedDevice.emission}%',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '15.400s',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: normalTextCol,

                            ),
                          ),
                          SizedBox(height: 1),
                          Row(
                            children: [

                              Text(
                                'Objectif de carbone',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
                ) ,//
                SizedBox(height: 30),
// co2
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        'Energie',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: normalTextCol,

                        ),
                      ),
                      Spacer(),
                      Text(
                        '${layCtr.selectedDevice.energy}',
                        style: TextStyle(
                          fontSize: 16,
                          color: transparentTextCol,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
