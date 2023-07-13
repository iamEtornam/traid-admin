import 'package:json_annotation/json_annotation.dart';

part 'admin.g.dart';

@JsonSerializable(explicitToJson: true)
class Admin {
  String userId;
  String email;
  String username;
  String firstName;
  String lastName;
  String fullName;
  String? phoneNumber;
  String locale;
  String currency;
  dynamic userStatus;
  List userRoles;
  dynamic organisation;
  String? orgId;
  List companies;
  bool emailVerified;
  bool phoneVerified;
  bool enabled;

  Admin({
    required this.userId,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    this.phoneNumber,
    required this.locale,
    required this.currency,
    this.userStatus,
    required this.userRoles,
    this.organisation,
    required this.orgId,
    required this.companies,
    required this.emailVerified,
    required this.phoneVerified,
    required this.enabled,
  });

  factory Admin.fromJson(Map<String, dynamic> datamap) => _$AdminFromJson(datamap);

  Map<String, dynamic> toJson() => _$AdminToJson(this);
}
