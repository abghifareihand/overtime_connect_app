import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportChartWidget extends StatelessWidget {
  final List<ChartData> data;

  const ReportChartWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF2FAFF),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      height: 250 + 20,
      child: SizedBox(
        height: 250,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SfCartesianChart(
            plotAreaBorderColor: const Color(0xFFB5CFFF),
            backgroundColor: const Color(0xFFF2FAFF),
            primaryXAxis: CategoryAxis(
              labelStyle: AppFont.medium.copyWith(
                color: AppColor.primary,
                fontSize: 10,
              ),
              axisLine: AxisLine(
                color: Color(0xFFB5CFFF),
                width: 1,
              ),
              majorGridLines: MajorGridLines(
                color: Color(0xFFB5CFFF),
                width: 1,
              ),
              majorTickLines: MajorTickLines(
                width: 0,
              ),
            ),
            primaryYAxis: NumericAxis(
              labelStyle: AppFont.medium.copyWith(
                color: AppColor.primary,
                fontSize: 10,
              ),
              axisLine: AxisLine(
                color: Color(0xFFB5CFFF),
                width: 1,
              ),
              majorGridLines: MajorGridLines(
                color: Color(0xFFB5CFFF),
                width: 1,
              ),
              majorTickLines: MajorTickLines(
                width: 0,
              ),
            ),
            series: [
              SplineSeries<ChartData, String>(
                dataSource: data,
                splineType: SplineType.monotonic,
                color: AppColor.primary,
                markerSettings: MarkerSettings(
                  isVisible: true,
                  color: AppColor.primary,
                  borderWidth: 0,
                ),
                xValueMapper: (ChartData data, _) => data.day,
                yValueMapper: (ChartData data, _) => data.overtimeHours,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String day;
  final int overtimeHours;

  ChartData(
    this.day,
    this.overtimeHours,
  );
}
