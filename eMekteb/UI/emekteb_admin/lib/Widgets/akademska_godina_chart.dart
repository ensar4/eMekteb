import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/akademska_godina.dart';

List<charts.Series<AkademskaGodina, String>> createSeries(List<AkademskaGodina> data) {
  return [
    charts.Series<AkademskaGodina, String>(
      id: 'ProsjecnaOcjena',
      domainFn: (AkademskaGodina godina, _) => godina.naziv.toString(),
      measureFn: (AkademskaGodina godina, _) => godina.prosjecnaOcjena ?? 0,
      data: data,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      displayName: 'Prosječna Ocjena',
    ),
    charts.Series<AkademskaGodina, String>(
      id: 'ProsjecnoPrisustvo',
      domainFn: (AkademskaGodina godina, _) => godina.naziv.toString(),
      measureFn: (AkademskaGodina godina, _) => godina.prosjecnoPrisustvo ?? 0,
      data: data,
      colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
      displayName: 'Prosječno Prisustvo',
    ),
    charts.Series<AkademskaGodina, String>(
      id: 'UkupnoMekteba',
      domainFn: (AkademskaGodina godina, _) => godina.naziv.toString(),
      measureFn: (AkademskaGodina godina, _) => godina.ukupnoMekteba ?? 0,
      data: data,
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      displayName: 'Ukupno Mekteba',
    ),
    charts.Series<AkademskaGodina, String>(
      id: 'UkupnoUcenika',
      domainFn: (AkademskaGodina godina, _) => godina.naziv.toString(),
      measureFn: (AkademskaGodina godina, _) => godina.ukupnoUcenika ?? 0,
      data: data,
      colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
      displayName: 'Ukupno Učenika',
    ),
  ];
}

class AkademskaGodinaChart extends StatelessWidget {
  final List<AkademskaGodina> data;

  AkademskaGodinaChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(16.0),
      child: charts.BarChart(
        createSeries(data),
        barGroupingType: charts.BarGroupingType.grouped,
        animate: true,
        behaviors: [
          charts.SeriesLegend(
            position: charts.BehaviorPosition.top,
            horizontalFirst: true,
            desiredMaxColumns: 4,
          ),
        ],
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            desiredTickCount: 3, // Number of horizontal lines
          ),
          renderSpec: charts.GridlineRendererSpec(
            // Customize the gridline configuration
            labelStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.gray.shadeDefault,
            ),
            lineStyle: charts.LineStyleSpec(
              color: charts.MaterialPalette.gray.shade300,
            ),
          ),
        ),
      ),
    );
  }
}
