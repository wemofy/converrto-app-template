import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

Future<FirebaseOptions> setupFirebase() async {
  String jsonContent = await rootBundle.loadString(
      'android/app/google-services.json');

  final jsonData = json.decode(jsonContent);

  final projectInfo = jsonData['project_info'];
  final client = jsonData['client'][0];
  final androidClientInfo = client['client_info']['android_client_info'];

  final apiKey = client['api_key'][0]['current_key'];
  final appId = client['client_info']['mobilesdk_app_id'];
  final projectId = projectInfo['project_id'];
  final messagingSenderId = projectInfo['project_number'];
  final storageBucket = projectInfo['storage_bucket'];

  print('Extracted values:');
  print('apiKey: $apiKey');
  print('appId: $appId');
  print('projectId: $projectId');
  print('messagingSenderId: $messagingSenderId');
  print('storageBucket: $storageBucket');

  return FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: storageBucket,
  );
}
