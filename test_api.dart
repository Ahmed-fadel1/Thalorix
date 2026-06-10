import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final baseUrl = 'http://127.0.0.1:5000/api/v1';
  
  try {
    // 1. Register new user
    final email = 'test_${DateTime.now().millisecondsSinceEpoch}@example.com';
    final registerRes = await HttpClient().postUrl(Uri.parse('$baseUrl/auth/mob/register'))
      ..headers.contentType = ContentType.json
      ..write(jsonEncode({'name': 'Test User', 'email': email, 'password': 'password123'}));
    final registerReply = await registerRes.close();
    final registerBody = await registerReply.transform(utf8.decoder).join();
    
    // 2. Login
    final loginRes = await HttpClient().postUrl(Uri.parse('$baseUrl/auth/mob/login'))
      ..headers.contentType = ContentType.json
      ..write(jsonEncode({'email': email, 'password': 'password123'}));
    final loginReply = await loginRes.close();
    final loginBody = await loginReply.transform(utf8.decoder).join();
    final loginData = jsonDecode(loginBody);
    final token = loginData['token'] ?? loginData['data']?['token'];
    
    if (token == null) {
      print('Failed to login: $loginBody');
      return;
    }
    
    print('Logged in successfully.');
    
    // 3. Get templates
    final tplRes = await HttpClient().getUrl(Uri.parse('$baseUrl/templates'));
    final tplReply = await tplRes.close();
    final tplBody = await tplReply.transform(utf8.decoder).join();
    final tplData = jsonDecode(tplBody);
    final templates = tplData['data'] ?? [];
    if (templates.isEmpty) {
      print('No templates found.');
      return;
    }
    final tpl1 = templates[0]['_id'];
    final tpl2 = templates.length > 1 ? templates[1]['_id'] : tpl1;
    final tpl3 = templates.length > 2 ? templates[2]['_id'] : tpl1;
    
    // 4. Add template 1
    final add1Res = await HttpClient().postUrl(Uri.parse('$baseUrl/orders'))
      ..headers.contentType = ContentType.json
      ..headers.add('Authorization', 'Bearer $token')
      ..write(jsonEncode({'templateId': tpl1, 'quantity': 1}));
    final add1Reply = await add1Res.close();
    print('Add 1 status: ${add1Reply.statusCode}');
    
    // 5. Add template 2
    final add2Res = await HttpClient().postUrl(Uri.parse('$baseUrl/orders'))
      ..headers.contentType = ContentType.json
      ..headers.add('Authorization', 'Bearer $token')
      ..write(jsonEncode({'templateId': tpl2, 'quantity': 1}));
    final add2Reply = await add2Res.close();
    print('Add 2 status: ${add2Reply.statusCode}');

    // 6. Add template 3
    final add3Res = await HttpClient().postUrl(Uri.parse('$baseUrl/orders'))
      ..headers.contentType = ContentType.json
      ..headers.add('Authorization', 'Bearer $token')
      ..write(jsonEncode({'templateId': tpl3, 'quantity': 1}));
    final add3Reply = await add3Res.close();
    print('Add 3 status: ${add3Reply.statusCode}');
    
    // 7. Get orders
    final getOrdersRes = await HttpClient().getUrl(Uri.parse('$baseUrl/orders/my-orders'))
      ..headers.add('Authorization', 'Bearer $token');
    final getOrdersReply = await getOrdersRes.close();
    final getOrdersBody = await getOrdersReply.transform(utf8.decoder).join();
    
    print('\n=== EXACT GET /my-orders RESPONSE ===');
    print(JsonEncoder.withIndent('  ').convert(jsonDecode(getOrdersBody)));
  } catch (e) {
    print('Error hitting local API: $e');
  }
}
