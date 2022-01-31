import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mess_record_app/model/profile/core/bill_settings.dart';

import 'package:mess_record_app/model/database.dart';

class BillSettingsWidget extends StatefulWidget {
  final BillSettings settings;
  const BillSettingsWidget({Key? key, required this.settings})
      : super(key: key);

  @override
  _BillSettingsWidgetState createState() =>
      _BillSettingsWidgetState(this.settings);
}

class _BillSettingsWidgetState extends State<BillSettingsWidget> {
  final BillSettings settings;
  TextEditingController _chargesController = TextEditingController();
  TimeOfDay pickedTime = TimeOfDay.now();
  DateTime pickedDate = DateTime.now();

  _BillSettingsWidgetState(this.settings) {
    _chargesController.text = settings.additionalCharges.toString();
    _chargesController.addListener(() {
      settings.additionalCharges = int.tryParse(_chargesController.text) ?? 0;
      // Database.saveProfile();
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    pickedTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: settings.notifyAt.hour, minute: settings.notifyAt.minute),
    ))!;
  }

  Future<void> _selectDate(BuildContext context) async {
    pickedDate = (await showDatePicker(
        context: context,
        initialDate: settings.notifyAt,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050)))!;
    pickedTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: settings.notifyAt.hour, minute: settings.notifyAt.minute),
    ))!;
    if (pickedDate != settings.notifyAt) {
      // _selectTime(context);
      setState(() {
        settings.notifyAt = DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, pickedTime.hour, pickedTime.minute);
        Database.saveProfile();
      });
    }
  }

  String getDateTimeString() {
    DateTime datetime = settings.notifyAt;
    return datetime.day.toString() +
        '/' +
        datetime.month.toString() +
        '/' +
        datetime.year.toString() +
        '  ' +
        getTimeString(datetime);
  }

  String getTimeString(DateTime datetime) {
    String timeString = '';
    String amperse = 'AM';
    if (datetime.hour < 10) {
      timeString += '0' + datetime.hour.toString();
    } else if (datetime.hour <= 12) {
      timeString += datetime.hour.toString();
    } else {
      timeString += (datetime.hour - 12).toString();
      amperse = 'PM';
    }
    timeString += ':';
    if (datetime.minute < 10) {
      timeString += '0' + datetime.minute.toString();
    } else {
      timeString += datetime.minute.toString();
    }
    timeString += ' ' + amperse;
    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Expanded(child: Text('Notify Me At')),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Center(
                      child: ElevatedButton(
                        child: Text(getDateTimeString()),
                        onPressed: () {
                          _selectDate(context);
                        },
                      ),
                    ),
                  ),
                  flex: 2,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                  child: Text('Any Additional Charges'),
                  flex: 3,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10.0, 10.0, 0),
                    child: TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _chargesController,
                      decoration: InputDecoration(
                        labelText: 'Charges',
                        // border: OutlineInputBorder(
                        //   borderSide:
                        //       const BorderSide(color: Colors.grey, width: 1),
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                      ),
                    ),
                  ),
                  flex: 2,
                ),
              ],
            ),
          ]),
        ));
  }

  @override
  void dispose() {
    _chargesController.dispose();
    super.dispose();
  }
}
