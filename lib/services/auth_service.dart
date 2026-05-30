import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import '../config.dart';
import 'storage_service.dart';

class AuthService {
  final StorageService _storage = StorageService();

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfo.iosInfo;
      String? identifier = await _storage.getSecureString('device_id');
      if (identifier == null) {
        identifier = iosInfo.identifierForVendor ?? DateTime.now().millisecondsSinceEpoch.toString();
        await _storage.saveSecureString('device_id', identifier);
      }
      return identifier;
    }

    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  String getPlatform() {
    if (defaultTargetPlatform == TargetPlatform.android) return 'android';
    if (defaultTargetPlatform == TargetPlatform.iOS) return 'ios';
    return 'unknown';
  }

  Future<Map<String, dynamic>> _login(String username, String loginUrl, String prefKey, String successMessage) async {
    try {
      final deviceId = await getDeviceId();
      final platform = getPlatform();

      final url = Uri.parse(loginUrl).replace(queryParameters: {
        'username': username,
        'android_id': deviceId,
        'device_id': deviceId,
        'platform': platform,
        'mobile': '1',
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = response.body;

        if (body.contains('تم التحقق بنجاح') || body.contains('success') || body.contains('تم تسجيل الدخول بنجاح')) {
          await _storage.saveUsername(prefKey, username);
          return {'success': true, 'message': successMessage};
        } else if (body.contains('هذا الحساب مرتبط بهاتف آخر') || body.contains('device already')) {
          return {'success': false, 'message': 'الحساب مستخدم على جهاز آخر'};
        } else if (body.contains('انتهت صلاحية الحساب') || body.contains('expired')) {
          return {'success': false, 'message': 'انتهت صلاحية الحساب'};
        } else if (body.contains('غير مصرح') || body.contains('not authorized')) {
          return {'success': false, 'message': 'هذا الحساب غير مسموح له بالدخول'};
        } else if (body.contains('تم الوصول للحد الأقصى') || body.contains('limit reached')) {
          return {'success': false, 'message': 'تجاوز الحد الأقصى للأجهزة'};
        } else {
          return {'success': false, 'message': 'اسم المستخدم غير صحيح'};
        }
      } else {
        return {'success': false, 'message': 'فشل الاتصال بالسيرفر'};
      }
    } catch (e) {
      return {'success': false, 'message': 'حدث خطأ في الاتصال'};
    }
  }

  Future<Map<String, dynamic>> fullLogin(String username) {
    return _login(username, AppConfig.fullLoginUrl, AppConfig.fullLoginPref, 'تم تسجيل الدخول بنجاح');
  }

  Future<Map<String, dynamic>> efLogin(String username) {
    return _login(username, AppConfig.efLoginUrl, AppConfig.efLoginPref, 'مرحباً في قسم المكثفة');
  }

  Future<Map<String, dynamic>> examsLogin(String username) {
    return _login(username, AppConfig.examsLoginUrl, AppConfig.examsLoginPref, 'مرحباً في قسم الاختبارات');
  }

  Future<void> registerDevice() async {
    try {
      final deviceId = await getDeviceId();
      final url = Uri.parse('${AppConfig.registerDeviceUrl}?android_id=$deviceId');
      await http.get(url);
    } catch (e) {}
  }

  Future<String?> getSavedUsername(String prefKey) async {
    return await _storage.getUsername(prefKey);
  }

  Future<void> logout(String prefKey) async {
    await _storage.removeUsername(prefKey);
  }
}