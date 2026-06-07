import 'package:expense_tracker/Utils/DateTimeUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DateSelectionTile extends StatelessWidget {
  void Function(DateTime) callBack;

  DateSelectionTile({required this.callBack})
    : selectedDate = ValueNotifier(DateTime.now());

  late ValueNotifier<DateTime> selectedDate;

  Future<void> changeSelectedDate(BuildContext context) async {
    DateTime? temp = await _datePicker(context);
    if (temp != null) {
      selectedDate.value = temp;
      callBack(selectedDate.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeSelectedDate(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: _buildText(),
      ),
    );
  }

  Widget _buildText() {
    return ValueListenableBuilder(
      valueListenable: selectedDate,
      builder: (_, value, _) {
        return Text(
          DateTimeUtils.format(dateTime: value),
          style: TextStyle(fontSize: 20),
        );
      },
    );
  }

  Future<DateTime?> _datePicker(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      // Optional: makes the dim background behind the picker fully transparent too
      barrierColor: Colors.transparent,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // Override the specific Date Picker component theme
            datePickerTheme: const DatePickerThemeData(
              backgroundColor:
                  Colors.black, // Makes the core dialog transparent
              surfaceTintColor:
                  Colors.transparent, // Disables the Material 3 tint overlay
              elevation: 0, // Removes the drop shadow structure
            ),

            // Optional dark text adjustment so dates remain legible on a clear backdrop
            colorScheme: const ColorScheme.light(
              onSurface: Colors.white, // Text color for regular days
              primary: Colors.deepOrange, // Color for selected day highlight
              onPrimary: Colors.white, // Text color for selected day
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
