import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FormFields extends StatelessWidget {
  final List<String> weightValues = ["pills", "ml", "mg"];
  final int howManyWeeks;
  final String selectedUnit;
  final Function onPopUpMenuChanged, onSliderChanged;
  final TextEditingController nameController;
  final TextEditingController amountController;
  FormFields(this.howManyWeeks,this.selectedUnit,this.onPopUpMenuChanged,this.onSliderChanged,this.nameController,this.amountController);

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return LayoutBuilder(
      builder:(context,constrains)=> Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: constrains.maxHeight * 0.32,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'نام دارو',
              ),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),

            ),
          ),
          SizedBox(
              height: constrains.maxHeight * 0.07,
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  height: constrains.maxHeight * 0.32,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                    hintText: 'مقدار',
                  ),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: constrains.maxHeight * 0.32,
                  child: DropdownButtonFormField(
                    onTap: ()=>focus.unfocus(),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        labelText: "واحد",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.5, color: Colors.grey))),
                    items: weightValues
                        .map((weight) => DropdownMenuItem(
                      child: Text(weight),
                      value: weight,
                    ))
                        .toList(),
                    onChanged: (value) => this.onPopUpMenuChanged(value),
                    value: selectedUnit,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: constrains.maxHeight * 0.1,
          ),
        ],
      ),
    );
  }
}
