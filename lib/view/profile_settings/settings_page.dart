import 'package:flutter/material.dart';
import 'package:mess_record_app/model/database.dart';
import 'package:mess_record_app/model/profile/core/day.dart';
import 'package:mess_record_app/model/profile/core/meal.dart';
import 'package:mess_record_app/view/profile_settings/bill_settings_widget.dart';
import 'package:mess_record_app/view/constants.dart';
import 'package:mess_record_app/view/profile_settings/daily_details_widget.dart';
import 'package:mess_record_app/view/profile_settings/meal_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _SettingsPageState();

  void removeMeal(Meal meal) {
    setState(() {
      Database.getDefaultProfile().removeMeal(meal);
      // Database.saveProfile();
    });
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Add Meals'),
          content: AddMealsWidget(),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Select Days'),
          content: SelectDaysWidget(),
        ),
        Step(
          state: _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text('Add Dishes'),
          content: AddDishesWidget(),
        ),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Bill Settings'),
            content: Center(
              child: BillSettingsWidget(
                  settings: Database.getDefaultProfile().billSettings),
            )),
      ];

  SizedBox AddDishesWidget() {
    return SizedBox(
      height: 400,
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: Database.getDefaultProfile()
            .days
            .iter()
            .where((element) => element.status)
            .map((e) => DailyDetailsWidget(dayMeals: e))
            .toList(),
      ),
    );
  }

  Column AddMealsWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: (Database.getDefaultProfile()
              .meals
              .map((e) => MealWidget(
                    meal: e,
                    removeMeal: removeMeal,
                  ))
              .toList()),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                Database.getDefaultProfile().addDefaultMeal();
                // Database.saveProfile();
              });
            },
            heroTag: 'Add Meal',
          ),
        )
      ],
    );
  }

  Center SelectDaysWidget() {
    return Center(
        child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: Database.getDefaultProfile()
                .days
                .iter()
                .map(
                  (e) => Container(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.day.toShortString().replaceAll('Day.', '')),
                          Switch(
                            onChanged: (bool value) {
                              setState(() {
                                e.status = value;
                                // Database.saveProfile();
                              });
                            },
                            value: e.status,
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList()));
  }

  int _activeStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Constants.appName),
        ),
        body: Stepper(
          controlsBuilder: (BuildContext context,
              {void Function()? onStepCancel,
              void Function()? onStepContinue}) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    onPressed: onStepCancel,
                    child: const Icon(Icons.arrow_upward),
                    heroTag: "previous",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    onPressed: onStepContinue,
                    child: const Icon(Icons.arrow_downward),
                    heroTag: "next",
                  ),
                ),
              ],
            );
          },
          steps: stepList(),
          currentStep: _activeStepIndex,
          onStepContinue: () {
            setState(() {
              if (_activeStepIndex < stepList().length - 1) {
                _activeStepIndex += 1;
              }
              // Database.saveProfile();
            });
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }
            setState(() {
              _activeStepIndex -= 1;
              // Database.saveProfile();
            });
          },
        ),
      ),
    );
  }
}
