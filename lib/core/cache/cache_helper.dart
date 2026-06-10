import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;


  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }


  static Future<void> saveToken(String token) async {
    await prefs.setString('token', token);
  }

  static String? getToken() {
    return prefs.getString('token');
  }

  static Future<void> saveName(String name) async {
    await prefs.setString('name', name);
  }

  static String? getName() {
    return prefs.getString('name');
  }

  static Future<void> saveUserId(String id) async {
    await prefs.setString('userId', id);
  }

  static String? getUserId() {
    return prefs.getString('userId');
  }

  // ==================== Likes ====================

  static Future<void> toggleLike(String postId) async {
    final likes = prefs.getStringList('likedPosts') ?? [];
    if (likes.contains(postId)) {
      likes.remove(postId);
    } else {
      likes.add(postId);
    }
    await prefs.setStringList('likedPosts', likes);
  }

  static bool isPostLiked(String postId) {
    final likes = prefs.getStringList('likedPosts') ?? [];
    return likes.contains(postId);
  }

  static Future<void> clearAll() async {
    await prefs.clear();
  }
}import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveLastOrder(Map<String, dynamic> orderJson) async {
    await prefs.setString('lastOrder', jsonEncode(orderJson));
  }

  static Map<String, dynamic>? getLastOrder() {
    final raw = prefs.getString('lastOrder');
    if (raw != null) {
      try {
        return jsonDecode(raw) as Map<String, dynamic>;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  static Future<void> clearLastOrder() async {
    await prefs.remove('lastOrder');
  }

  static Future<void> saveToken(String token) async {
    await prefs.setString('token', token);
  }

  static String? getToken() {
    return prefs.getString('token');
  }

  static Future<void> saveName(String name) async {
    await prefs.setString('name', name);
  }

  static String? getName() {
    return prefs.getString('name');
  }

  static Future<void> clearAll() async {
    await prefs.clear();
  }

  static Future<void> saveUserId(String userId) async {
    await prefs.setString('userId', userId);
  }

  static String? getUserId() {
    return prefs.getString('userId');
  }

  static Future<void> clearUserId() async {
    await prefs.remove('userId');
  }
}
