import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Statistik extends StatefulWidget {
  const Statistik({Key? key}) : super(key: key);

  @override
  StatistikState createState() => StatistikState();
}

class StatistikState extends State<Statistik> {
  Future<int> lengthSatu() async {
    int length = await FirebaseFirestore.instance
        .collection('rapor')
        .where('kls', isEqualTo: '1 (Satu)')
        .get()
        .then((value) => value.size);
    return length;
  }

  List<_RaporData> data = [
    _RaporData('Kelas 1', 4),
    _RaporData('Kelas 2', 3),
    _RaporData('Kelas 3', 2),
    _RaporData('Kelas 4', 1),
    _RaporData('Kelas 5', 0),
    _RaporData('Kelas 6', 0)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
          title: const Text(
            'Statistik Rapor',
            style: TextStyle(fontFamily: 'Montserrat Medium'),
          ),
          gradient: const LinearGradient(
              colors: [Colors.green, Colors.cyan, Colors.blue]),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(children: [
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(
                  text: 'Data Rapor Siswa', textStyle: GoogleFonts.poppins()),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_RaporData, String>>[
                LineSeries<_RaporData, String>(
                    dataSource: data,
                    xValueMapper: (rapor, _) => rapor.kls,
                    yValueMapper: (rapor, _) => rapor.rapor,
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SfSparkLineChart.custom(
                trackball: const SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                marker: const SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (index) => data[index].kls,
                yValueMapper: (index) => data[index].rapor,
                dataCount: 5,
              ),
            ),
          )
        ]));
  }
}

class _RaporData {
  _RaporData(this.kls, this.rapor);

  final String kls;
  final double rapor;
}
