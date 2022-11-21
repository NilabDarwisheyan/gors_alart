import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/pill.dart';
import '../../screens/home/medicines_list.dart';
import '../../screens/home/calendar.dart';
import '../../models/calendar_day_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Pill> allListOfPills = List<Pill>();
  int _selectedDayIndex = 0;
  List<Pill> selectedDaysPills = List<Pill>();


  List<CalendarDayModel> _nextSevenDays;


  @override
  void initState() {
    super.initState();
    _nextSevenDays = CalendarDayModel.getCurrentDays();
    setData();
  }


  //--------------------GET ALL DATA FROM DATABASE---------------------
  Future setData() async {
    allListOfPills.clear();
    Pill.pills.forEach((key, value) {allListOfPills.add(value);});

    chooseDay(_nextSevenDays[_selectedDayIndex]);
  }
  //===================================================================

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final Widget addButton = FloatingActionButton(
      elevation: 2.0,
      onPressed: () async {
        //refresh the pills from database
        await Navigator.pushNamed(context, "/add_new_medicine")
            .then((_) => setData());
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 24.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );

    return Scaffold(
      floatingActionButton: addButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.0, left: 25.0, right: 25.0, bottom: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: deviceHeight * 0.1,
                    child:Text(
                      "تقویم",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(color: Colors.black),
                    )
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Calendar(chooseDay,_nextSevenDays),
                ),
                SizedBox(
                    height: deviceHeight * 0.03
                ),
                selectedDaysPills.isEmpty
                    ?  Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: deviceHeight*0.2),
                        child: Container(
                            alignment: Alignment.topCenter,
                            height: deviceHeight * 0.1,
                            child:Text(
                              "امروز دارو نداری",
                              style:TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25.0,
                                fontFamily: "Popins")
                            )
                        ),
                      )
                    : MedicinesList(selectedDaysPills,setData)
              ],
            ),
          ),
        ),
      ),
    );
  }


  //-------------------------| Click on the calendar day |-------------------------

  void chooseDay(CalendarDayModel clickedDay){
    setState(() {
      _selectedDayIndex = _nextSevenDays.indexOf(clickedDay);
      _nextSevenDays.forEach((day) => day.isChecked = false );
      CalendarDayModel chooseDay = _nextSevenDays[_nextSevenDays.indexOf(clickedDay)];
      chooseDay.isChecked = true;
      selectedDaysPills.clear();
      allListOfPills.forEach((pill) {
        DateTime pillDate = DateTime.fromMicrosecondsSinceEpoch(pill.time * 1000);
        if(chooseDay.dayNumber == pillDate.day && chooseDay.month == pillDate.month && chooseDay.year == pillDate.year){
          selectedDaysPills.add(pill);
        }
      });
      selectedDaysPills.sort((pill1,pill2) => pill1.time.compareTo(pill2.time));
    });
  }

  //===============================================================================


}
