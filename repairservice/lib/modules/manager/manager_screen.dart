import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';
import 'package:repairservice/config/themes/light_theme.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:repairservice/modules/manager/models/event_model.dart';
import 'package:repairservice/widgets/title_text.dart';
import 'package:table_calendar/table_calendar.dart';

class ManagerScreen extends StatefulWidget {
  @override
  _ManagerScreenState createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen>
    with TickerProviderStateMixin {
  List _selectedEvents;

  Map<DateTime, List> _events;
  CalendarController _calendarController;
  AnimationController _animationController;

  Future<List<Datum>> getAllEvent() async {
    try {
      String responseString = '''{
    "status": "ok",
    "message": "Event Is Found",
    "data": [
      {
        "kodeEvent": "1",
        "tanggalEvent": "2021-01-15",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Lombok",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8cd198530_202002181405.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "0",
        "createTime": "2021-01-29 16:37:26",
        "updateBy": "",
        "updateTime": "2020-02-18 14:05:53"
      },
      {
        "kodeEvent": "2",
        "tanggalEvent": "2021-03-31",
        "judulEvent": "Bangun Kembali 100 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Jakarta",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d3d74b44_202002181407.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:07:41",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }, 
      {
        "kodeEvent": "3",
        "tanggalEvent": "2021-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }, 
      {
        "kodeEvent": "3",
        "tanggalEvent": "2021-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }, 
      {
        "kodeEvent": "3",
        "tanggalEvent": "2021-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }, 
      {
        "kodeEvent": "3",
        "tanggalEvent": "2021-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }, 
      {
        "kodeEvent": "3",
        "tanggalEvent": "2021-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }, 
      {
        "kodeEvent": "3",
        "tanggalEvent": "2021-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }, 
      {
        "kodeEvent": "3",
        "tanggalEvent": "2021-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }, 
      {
        "kodeEvent": "3",
        "tanggalEvent": "2021-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }, 
      {
        "kodeEvent": "3",
        "tanggalEvent": "2021-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }, 
      {
        "kodeEvent": "3",
        "tanggalEvent": "2021-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2021-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }
    ]
  }''';
      final Map<String, dynamic> responseJson = json.decode(responseString);
      if (responseJson["status"] == "ok") {
        List eventList = responseJson['data'];
        final result =
            eventList.map<Datum>((json) => Datum.fromJson(json)).toList();
        return result;
      } else {
        //throw CustomError(responseJson['message']);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Map<DateTime, List>> getTask1() async {
    Map<DateTime, List> mapFetch = {};
    List<Datum> event = await getAllEvent();
    for (int i = 0; i < event.length; i++) {
      var createTime = DateTime(event[i].createTime.year,
          event[i].createTime.month, event[i].createTime.day);

      var original = mapFetch[createTime];
      if (original == null) {
        print("null");
        mapFetch[createTime] = [event[i].tanggalEvent];
      } else {
        print(event[i].tanggalEvent);
        mapFetch[createTime] = List.from(original)
          ..addAll([event[i].tanggalEvent]);
      }
    }

    return mapFetch;
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    print(events);
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  void initState() {
    super.initState();
    //final _selectedDay = DateTime.now();
    _selectedEvents = [];
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTask1().then((val) => setState(() {
            _events = val;
          }));
      //print( ' ${_events.toString()} ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          text: "Quản lý việc",
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent[700],
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: kDefaultPadding),
          //   child: TitleText(
          //     text: "Quản lý việc",
          //     fontWeight: FontWeight.w600,
          //     fontSize: 14,
          //   ),
          // ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Scaffold(
                  appBar: TabBar(
                      indicator: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: LightColor.orange,
                        //borderRadius: BorderRadius.circular(10)
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.calendar_today),
                              Text('Lịch'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.view_list),
                              Text('Danh sách'),
                            ],
                          ),
                        ),
                      ]),
                  body: TabBarView(
                    children: [
                      Tab(
                        child: RefreshIndicator(
                          child: Column(
                            children: [
                              _buildTableCalendarWithBuilders(),
                              const SizedBox(height: 8.0),
                              const SizedBox(height: 8.0),
                              Expanded(child: _buildEventList()),
                            ],
                          ),
                          onRefresh: () async {
                            Completer<Null> completer = new Completer<Null>();
                            await Future.delayed(Duration(seconds: 2))
                                .then((onvalue) {
                              completer.complete();
                              setState(() {});
                            });
                            return completer.future;
                          },
                        ),
                      ),
                      Tab(
                        child: RefreshIndicator(
                          child: ListView(
                            physics: AlwaysScrollableScrollPhysics(),
                            children: [
                              Container(
                                height: AppTheme.fullWidth(context),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          onRefresh: () async {
                            Completer<Null> completer = new Completer<Null>();
                            await Future.delayed(Duration(seconds: 2))
                                .then((onvalue) {
                              completer.complete();
                              setState(() {});
                            });
                            return completer.future;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      //locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      //holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.greenAccent,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(fontSize: 18.0),
                ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: LightColor.orange,
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 18.0),
              ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events, _) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

// notification when onpress day
  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents.map((event) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text(event.toString()),
            onTap: () => print('$event tapped!'),
          ),
        );
      }).toList(),
    );
  }
}
