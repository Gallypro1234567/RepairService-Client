// To parse this JSON data, do
//
//     final Event = EventFromJson(jsonString);

import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.kodeEvent,
    this.tanggalEvent,
    this.judulEvent,
    this.lokasiEvent,
    this.isiEvent,
    this.fotoEvent,
    this.waktuEvent,
    this.statusEvent,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
  });

  String kodeEvent;
  DateTime tanggalEvent;
  String judulEvent;
  String lokasiEvent;
  String isiEvent;
  String fotoEvent;
  String waktuEvent;
  String statusEvent;
  String createBy;
  DateTime createTime;
  String updateBy;
  String updateTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kodeEvent: json["kodeEvent"],
        tanggalEvent: DateTime.parse(json["tanggalEvent"]),
        judulEvent: json["judulEvent"],
        lokasiEvent: json["lokasiEvent"],
        isiEvent: json["isiEvent"],
        fotoEvent: json["fotoEvent"],
        waktuEvent: json["waktuEvent"],
        statusEvent: json["statusEvent"],
        createBy: json["createBy"],
        createTime: DateTime.parse(json["createTime"]),
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() => {
        "kodeEvent": kodeEvent,
        "tanggalEvent":
            "${tanggalEvent.year.toString().padLeft(4, '0')}-${tanggalEvent.month.toString().padLeft(2, '0')}-${tanggalEvent.day.toString().padLeft(2, '0')}",
        "judulEvent": judulEvent,
        "lokasiEvent": lokasiEvent,
        "isiEvent": isiEvent,
        "fotoEvent": fotoEvent,
        "waktuEvent": waktuEvent,
        "statusEvent": statusEvent,
        "createBy": createBy,
        "createTime": createTime.toIso8601String(),
        "updateBy": updateBy,
        "updateTime": updateTime,
      };
}

List abc = [
  {
    "status": "ok",
    "message": "Event Is Found",
    "data": [
      {
        "kodeEvent": "1",
        "tanggalEvent": "2020-01-15",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Lombok",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8cd198530_202002181405.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "0",
        "createTime": "2020-01-29 16:37:26",
        "updateBy": "",
        "updateTime": "2020-02-18 14:05:53"
      },
      {
        "kodeEvent": "2",
        "tanggalEvent": "2020-03-31",
        "judulEvent": "Bangun Kembali 100 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Jakarta",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d3d74b44_202002181407.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2020-02-18 14:07:41",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      },
      {
        "kodeEvent": "3",
        "tanggalEvent": "2020-01-31",
        "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
        "lokasiEvent": "Bandung",
        "isiEvent":
            "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
        "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
        "waktuEvent": "09:00 s.d Selesai",
        "statusEvent": "t",
        "createBy": "",
        "createTime": "2020-02-18 14:08:34",
        "updateBy": "",
        "updateTime": "0000-00-00 00:00:00"
      }
    ]
  }
];
