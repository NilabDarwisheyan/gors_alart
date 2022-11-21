import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:medicine/models/medicine_type.dart';
import 'package:medicine/models/pill.dart';
import '../../helpers/platform_flat_button.dart';
import '../../screens/add_new_medicine/form_fields.dart';
import '../../screens/add_new_medicine/medicine_type_card.dart';

class AddNewMedicine extends StatefulWidget {
  @override
  _AddNewMedicineState createState() => _AddNewMedicineState();
}

class _AddNewMedicineState extends State<AddNewMedicine> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //medicine types
  final List<String> pillUnits = ["pills", "ml", "mg"];

  //list of medicines forms objects
  final List<MedicineForm> medicineForms = [
    MedicineForm("Syrup", Image.asset("assets/images/syrup.png"), true),
    MedicineForm(
        "Pill", Image.asset("assets/images/pills.png"), false),
    MedicineForm(
        "Capsule", Image.asset("assets/images/capsule.png"), false),
    MedicineForm(
        "Cream", Image.asset("assets/images/cream.png"), false),
    MedicineForm(
        "Drops", Image.asset("assets/images/drops.png"), false),
    MedicineForm(
        "Syringe", Image.asset("assets/images/syringe.png"), false),
  ];

  //-------------Pill object------------------
  int howManyWeeks = 1;
  String selectedUnit;
  DateTime selectedDate = DateTime.now();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();


  @override
  void initState() {
    super.initState();
    selectedUnit = pillUnits[0];
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery
        .of(context)
        .size
        .height - 60.0;

    return
      Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: deviceHeight * 0.05,
                child: FittedBox(
                  child: InkWell(
                    child: Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(left: 15.0),
                height: deviceHeight * 0.05,
                alignment: Alignment.topCenter,
                child: FittedBox(
                    child: Text(
                      "افزودن دارو",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.black),
                    )),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              Container(
                height: deviceHeight * 0.30,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FormFields(
                        howManyWeeks,
                        selectedUnit,
                        onPopUpMenuItemChanged,
                        onSliderChanged,
                        nameController,
                        amountController)),
              ),
              Container(
                height: deviceHeight * 0.035,
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),

                  child: FittedBox(
                    child: Text(
                      "نوعیت دارو",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Container(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...medicineForms.map(
                            (type) => MedicineTypeCard(type, medicineFormClick))
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              Container(
                width: double.infinity,
                height: deviceHeight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: PlatformFlatButton(
                          handler: () => openTimePicker(),
                          buttonChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                DateFormat.Hm().format(this.selectedDate),
                                style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.access_time,
                                size: 30,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                              )
                            ],
                          ),
                          color: Color.fromRGBO(7, 190, 200, 0.1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: PlatformFlatButton(
                          handler: () => openDatePicker(),
                          buttonChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                DateFormat("dd.MM").format(this.selectedDate),
                                style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.event,
                                size: 30,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                              )
                            ],
                          ),
                          color: Color.fromRGBO(7, 190, 200, 0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: deviceHeight * 0.09,
                width: double.infinity,
                child: PlatformFlatButton(
                  handler: () async => savePill(),
                  color: Theme
                      .of(context)
                      .primaryColor,
                  buttonChild: Text(
                    "ذخیره",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //slider changer
  void onSliderChanged(double value) =>
      setState(() => this.howManyWeeks = value.round());

  //choose popum menu item
  void onPopUpMenuItemChanged(String value) =>
      setState(() => this.selectedUnit = value);


  Future<void> openTimePicker() async {
    await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: "انتخاب ساعت")
        .then((value) {
      if (value != null) {
        DateTime newDate = DateTime(selectedDate.year,
            selectedDate.month,
            selectedDate.day, value.hour, value.minute);
        setState(() => selectedDate = newDate);
      }
    });
  }

  Future<void> openDatePicker() async {
    await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 100000)),
        helpText: 'انتخاب تاریخ'
    )
        .then((value) {
      if (value != null) {
        DateTime newDate = DateTime(
            value.year, value.month, value.day, selectedDate.hour,
            selectedDate.minute);
        setState(() => selectedDate = newDate);
      }
    });
  }

  savePill() {

    if (selectedDate.millisecondsSinceEpoch >=
        DateTime
            .now()
            .millisecondsSinceEpoch) {
      //create pill object
      Pill pill = Pill(
          amount: amountController.text,
          howManyWeeks: howManyWeeks,
          medicineForm: medicineForms[medicineForms.indexWhere((
              element) => element.isChoose == true)].name,
          name: nameController.text,
          time: selectedDate.millisecondsSinceEpoch,
          type: selectedUnit,
          notifyId: Random().nextInt(10000000));

      Pill.addPill(pill);

      Navigator.pop(context);
    }
  }

  void medicineFormClick(MedicineForm medicine) {
    setState(() {
      medicineForms.forEach((medicineType) => medicineType.isChoose = false);
      medicineForms[medicineForms.indexOf(medicine)].isChoose = true;
    });
  }
}

