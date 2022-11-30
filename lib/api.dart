// API service for the application.

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ua_app_secu/models/item.dart';
import 'package:ua_app_secu/models/log.dart';
import 'package:ua_app_secu/models/player.dart';

class Api {
  static String baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

  // get headers based on token
  Map<String, String> getHeaders(String? bearerToken) {
    Map<String, String> base = <String, String>{
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
    };
    bearerToken != null
        ? base.addAll({'Authorization': 'Bearer $bearerToken'})
        : null;
    return base;
  }

  String getBearerToken() {
    return GetStorage().read('token');
  }

  // send get request with http module
  Future<Map<String, dynamic>?> get(String url, String? bearerToken,
      {int expectedCode = 200}) async {
    return http
        .get(Uri.parse(baseUrl + url), headers: getHeaders(bearerToken))
        .then((response) {
      if (response.statusCode == expectedCode) {
        return jsonDecode(response.body.toString());
      } else {
        return null;
      }
    });
  }

  // send post request with http module
  Future<Map<String, dynamic>?> post(
      String url, String? bearerToken, String body,
      {int expectedCode = 200}) async {
    http.post(Uri.parse(baseUrl + url),
        headers: getHeaders(bearerToken), body: body);

    return http
        .post(Uri.parse(baseUrl + url),
            headers: getHeaders(bearerToken), body: body)
        .then((response) {
      if (response.statusCode == expectedCode) {
        return jsonDecode(response.body.toString());
      } else {
        return null;
      }
    });
  }

  // send delete request with http module
  Future<Map<String, dynamic>?> delete(String url, String? bearerToken,
      {int expectedCode = 200}) async {
    return http
        .delete(Uri.parse(baseUrl + url), headers: getHeaders(bearerToken))
        .then((response) {
      if (response.statusCode == expectedCode) {
        return jsonDecode(response.body.toString());
      } else {
        return null;
      }
    });
  }

  Future<Player?> getPlayer(Uint8List code) async {
    String codeToBase64 = base64Encode(code);

    Map<String, dynamic>? json =
        await get("/admin/repo/user?id=$codeToBase64", getBearerToken());

    return json != null ? Player.fromJson(json) : null;
  }

  Future<Map<String, dynamic>?> scanTicket(Uint8List code) async {
    String codeToBase64 = base64Encode(code);

    return await post("/admin/repo/user?id=$codeToBase64", getBearerToken(),
        jsonEncode({'qrcode': codeToBase64}));
  }

  Future<Map<String, dynamic>?> addPlayerItem(
      Player player, List<Item> items) async {
    return await post("/admin/repo/user/${player.id}/items", getBearerToken(),
        '{"items": ${jsonEncode(items)}}',
        expectedCode: 201);
  }

  Future<Map<String, dynamic>?> removePlayerItems(
      Player player, Item item) async {
    return await delete(
        "/admin/repo/user/${player.id}/items/${item.id}", getBearerToken(),
        expectedCode: 201);
  }

  Future<List<Log>?> getLogs(Player player) async {
    Map<String, dynamic>? json =
        await get("/admin/repo/user/${player.id}/logs", getBearerToken());

    return json != null
        ? (json['logs'] as List).map((e) => Log.fromJson(e)).toList()
        : null;
  }

  Future<Map<String, dynamic>?> login(String login, String password) async {
    return await post("/auth/login", null,
        jsonEncode({"login": login, "password": password}));
  }
}
