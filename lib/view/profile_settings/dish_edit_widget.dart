import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mess_record_app/model/profile/core/dish.dart';
import 'package:mess_record_app/model/profile/core/meal.dart';

class DishEditWidget extends StatefulWidget {
  final Meal meal;
  final Dish dish;
  final Function(Meal, Dish) updateDish;
  const DishEditWidget(
      {Key? key,
      required this.meal,
      required this.dish,
      required this.updateDish})
      : super(key: key);

  @override
  _DishEditWidgetState createState() => _DishEditWidgetState(meal, dish);
}

class _DishEditWidgetState extends State<DishEditWidget> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final Meal meal;
  final Dish dish;

  _DishEditWidgetState(this.meal, this.dish) {
    _nameController.text = dish.dishName;
    if (dish.dishName == "Enter Dish Name") {
      _nameController.text = '';
    }
    _priceController.text = dish.dishPrice.toString();
    _nameController.addListener(() {
      dish.dishName = _nameController.text;
    });
    _priceController.addListener(() {
      dish.dishPrice = int.tryParse(_priceController.text) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
              child: Text(meal.name)),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Dish Name',
                      // border: OutlineInputBorder(
                      //   borderSide:
                      //       const BorderSide(color: Colors.grey, width: 1),
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                    ),
                  ),
                  flex: 3,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        if (!hasFocus) {
                          widget.updateDish(meal, dish);
                        }
                      },
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        // keyboardType:
                        //     TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Dish Price',
                          // border: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //       color: Colors.grey, width: 1),
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                        ),
                      ),
                    ),
                  ),
                  flex: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
