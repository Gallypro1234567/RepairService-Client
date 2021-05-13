import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int type;
  final String solrId;
  final int id;
  final String title;
  final int stt;
  final dynamic created;
  final dynamic updated;
  final int totalDoanhNghiep;

  City(
      {this.type,
      this.solrId,
      this.id,
      this.title,
      this.stt,
      this.created,
      this.updated,
      this.totalDoanhNghiep});
  @override
  List<Object> get props =>
      [type, solrId, id, title, stt, created, updated, totalDoanhNghiep];
}

class District extends Equatable {
  final int type;
  final String solrId;
  final int id;
  final String title;
  final int stt;
  final int tinhThanhId;
  final String tinhThanhTitle;
  final String tinhThanhTitleAscii;
  final dynamic created;
  final dynamic updated;
  final dynamic isActived;
  District(
      {this.type,
      this.solrId,
      this.id,
      this.title,
      this.stt,
      this.tinhThanhId,
      this.tinhThanhTitle,
      this.tinhThanhTitleAscii, this.isActived,
      this.created,
      this.updated});
  @override
  List<Object> get props => [
        type,
        solrId,
        id,
        title,
        stt,
        tinhThanhId,
        tinhThanhTitle,
        tinhThanhTitleAscii,isActived,
        created,
        updated
      ];
}

class Ward extends Equatable {
  final int type;
  final String solrId;
  final int id;
  final String title;
  final int stt;
  final int tinhThanhId;
  final String tinhThanhTitle;
  final String tinhThanhTitleAscii;
  final int quanHuyenId;
  final String quanHuyenTitle;
  final String quanHuyenTitleAscii; 
  final dynamic created;
  final dynamic updated;

  Ward(
      {this.type,
      this.solrId,
      this.id,
      this.title,
      this.stt,
      this.tinhThanhId,
      this.tinhThanhTitle,
      this.tinhThanhTitleAscii,
      this.quanHuyenId,
      this.quanHuyenTitle,
      this.quanHuyenTitleAscii,
      this.created,
      this.updated});

  @override
  List<Object> get props => [
        type,
        solrId,
        id,
        title,
        stt,
        tinhThanhId,
        tinhThanhTitle,
        tinhThanhTitleAscii,
        quanHuyenId,
        quanHuyenTitle,
        quanHuyenTitleAscii,
        created,
        updated
      ];
}
