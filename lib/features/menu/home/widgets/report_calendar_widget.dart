import 'package:flutter/material.dart';
import 'package:overtime_connect_app/ui/shared/app_color.dart';
import 'package:overtime_connect_app/ui/shared/app_font.dart';
import 'package:overtime_connect_app/ui/utils/extensions.dart';
import 'package:table_calendar/table_calendar.dart';

class ReportCalendarWidget extends StatelessWidget {
  final bool Function(DateTime) isToday;
  final bool Function(DateTime) hasOvertime;
  final bool Function(DateTime) disableOvertime;
  final String Function(DateTime) overtimeText;
  const ReportCalendarWidget({
    super.key,
    required this.isToday,
    required this.hasOvertime,
    required this.disableOvertime,
    required this.overtimeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF2FAFF),
      ),
      child: TableCalendar(
        availableGestures: AvailableGestures.none, // enable scrolling
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: false,
          leftChevronVisible: false,
          rightChevronVisible: false,
          headerMargin: EdgeInsets.zero,
        ),
        daysOfWeekHeight: 0,
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2025, 01, 01),
        lastDay: DateTime.utc(2025, 12, 31),
        calendarStyle: CalendarStyle(
          defaultTextStyle: AppFont.medium.copyWith(
            color: AppColor.black,
            fontSize: 12,
          ),
          weekendTextStyle: AppFont.medium.copyWith(
            color: AppColor.black,
            fontSize: 12,
          ),
          outsideTextStyle: AppFont.medium.copyWith(
            color: Colors.transparent,
            fontSize: 12,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, focusedDay) {
            String monthYear = focusedDay.toMonthYearIndo();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  monthYear,
                  style: AppFont.semiBold.copyWith(
                    color: AppColor.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Min',
                            style: AppFont.regular.copyWith(
                              color: AppColor.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Sen',
                            style: AppFont.regular.copyWith(
                              color: AppColor.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Sel',
                            style: AppFont.regular.copyWith(
                              color: AppColor.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Rab',
                            style: AppFont.regular.copyWith(
                              color: AppColor.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Kam',
                            style: AppFont.regular.copyWith(
                              color: AppColor.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Jum',
                            style: AppFont.regular.copyWith(
                              color: AppColor.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Sab',
                            style: AppFont.regular.copyWith(
                              color: AppColor.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },

          // Indikator bulat kecil di bawah tanggal hari ini
          todayBuilder: (context, day, focusedDay) {
            return SizedBox.shrink();
          },

          markerBuilder: (context, day, events) {
            bool today = isToday(day);
            bool overtime = hasOvertime(day);
            bool noneOvertime = disableOvertime(day);
            String title = overtimeText(day);

            if (today && overtime) {
              return Stack(
                clipBehavior: Clip.none, // Allow the red circle to overflow outside the container
                children: [
                  Container(
                    margin: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${day.day}',
                          style: AppFont.semiBold.copyWith(
                            color: AppColor.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '+$title',
                          style: AppFont.medium.copyWith(
                            color: Color(0xFF10FA47),
                            fontSize: 8,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Red circle indicator for today, positioned outside the container
                  Positioned(
                    top: 2, // Adjust the positioning as needed
                    right: 2, // Adjust the positioning as needed
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              );
            }
            if (overtime) {
              // String overtimeText = model.getOvertimeText(day);
              return Container(
                margin: EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: noneOvertime ? AppColor.gray : AppColor.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${day.day}',
                      style: AppFont.semiBold.copyWith(
                        color: AppColor.white,
                        fontSize: 12,
                      ),
                    ),
                    if (!noneOvertime)
                      Text(
                        '+$title',
                        style: AppFont.medium.copyWith(
                          color: Color(0xFF10FA47),
                          fontSize: 8,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              );
            }

            if (today) {
              return Container(
                margin: EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${day.day}',
                  style: AppFont.semiBold.copyWith(
                    color: AppColor.white,
                    fontSize: 12,
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
        selectedDayPredicate: (day) => false,
      ),
    );
  }
}
