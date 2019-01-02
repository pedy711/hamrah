import 'package:json_annotation/json_annotation.dart';
import 'package:hamrah/model/communication/dsResponse.dart';

part 'dataSourceResponse.g.dart';

@JsonSerializable()
class DataSourceResponse{
  DsResponse response;

  DataSourceResponse(this.response);

  factory DataSourceResponse.fromJson(Map<String, dynamic> json) => _$DataSourceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceResponseToJson(this);
}