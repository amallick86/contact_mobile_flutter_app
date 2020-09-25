import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
    print(_selectedEvents);
  }

  List _selectedEvents;
  DateTime _selectedDay;

  final Map<DateTime, List> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Calendar")),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Calendar(
                startOnMonday: true,
                weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                events: _events,
                // onRangeSelected: (range) =>
                //     print("Range is ${range.from}, ${range.to}"),
                // onDateSelected: (date) => _handleNewDate(date),
                isExpandable: true,
                isExpanded: true,
                eventDoneColor: Colors.green,
                selectedColor: Colors.pink,
                todayColor: Colors.red,
                eventColor: Colors.grey,
                bottomBarArrowColor: Theme.of(context).iconTheme.color,
                dayOfWeekStyle: TextStyle(
                    color:
                        Theme.of(context).inputDecorationTheme.labelStyle.color,
                    fontWeight: FontWeight.w800,
                    fontSize: 11),
              ),
            ),
            _buildEventList()
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
          child: Card(
            child: ListTile(
              title: Text(_selectedEvents[index]['name'].toString()),
              onTap: () {},
            ),
          ),
        ),
        itemCount: _selectedEvents.length,
      ),
    );
  }
}
