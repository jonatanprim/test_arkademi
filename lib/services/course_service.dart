import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class CourseService{
  static var clientRetry = const RetryOptions(maxAttempts: 3,);
  static var client = http.Client();

  Future getDetailCourse() async{
    final url = Uri.parse('https://engineer-test-eight.vercel.app/course-status.json');
    try{
      var response = await clientRetry.retry(() => client.get(url,).timeout(const Duration(seconds: 8)), retryIf: (e) => e is SocketException || e is TimeoutException,);
      var body = jsonDecode(response.body);
      if(response.statusCode == 200){
        return body;
      }
      else{
        return null;
      }
    }
    catch (e){
      return null;
    }
  }


}