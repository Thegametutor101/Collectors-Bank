import 'dart:convert';
import 'dart:ffi';
import 'package:collectors_bank/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class CollectorsBankTcgPlayer {
  static Future<ModelTcgPlayerToken> generateTcgPlayerToken() async {
    final response = await http.get(Uri.parse(APIConstants.scryfallSets),
        headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      ModelTcgPlayerToken tcgPlayerToken =
          ModelTcgPlayerToken.fromJson(jsonData);
      return tcgPlayerToken;
    } else {
      throw Exception(
          'Sorry!\nFailed to retreive Magic the Gathering sets from our servers.');
    }
  }
}

class ModelTcgPlayerToken {
  final Long access_token;
  final String token_type;
  final double expires_in;
  final Long userName;
  final String issued;
  final String expires;

  ModelTcgPlayerToken(
      {required this.access_token,
      required this.token_type,
      required this.expires_in,
      required this.userName,
      required this.issued,
      required this.expires});

  static ModelTcgPlayerToken fromJson(Map<String, Object?> json) =>
      ModelTcgPlayerToken(
        access_token: json["access_token"] as Long,
        token_type: json["token_type"] as String,
        expires_in: json["expires_in"] as double,
        userName: json["userName"] as Long,
        issued: json[".issued"] as String,
        expires: json[".expires"] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      "access_token": access_token,
      "token_type": token_type,
      "expires_in": expires_in.toString(),
      "userName": userName,
      ".issued": issued,
      ".expires": expires
    };
  }
}
