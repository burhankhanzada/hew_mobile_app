// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:flutter/widgets.dart';

@immutable
class UserModel {
  const UserModel({
    this.userId,
    this.userName,
    this.displayName,
    this.phoneNumber,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      userName: map['userName'],
      displayName: map['displayName'],
      phoneNumber: map['phoneNumber'],
    );
  }
  final String? userId;
  final String? userName;
  final String? displayName;
  final String? phoneNumber;

  UserModel copyWith({
    String? userId,
    String? userName,
    String? displayName,
    String? phoneNumber,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, displayName: $displayName, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.userName == userName &&
        other.displayName == displayName &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        displayName.hashCode ^
        phoneNumber.hashCode;
  }
}
