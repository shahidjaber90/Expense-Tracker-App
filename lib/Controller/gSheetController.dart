import 'dart:convert';
import 'package:expenses/Model/gSheetData.dart';
import 'package:http/http.dart' as http;

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Google App Script Web URL.

//   addUsers(data) {
//   const url = 'https://maaz-api.tga-edu.com/api/users';
//   var baseUrl = Uri.parse(url);
//   var response = http.post(baseUrl,
//       body: jsonEncode(data), headers: {"content-type": "application/json"});
//   print(response);
//   return response;
// }

// getUsers() async {
//   const url = 'https://maaz-api.tga-edu.com/api/users';
//   var baseUrl = Uri.parse(url);
//   var response = await http.get(baseUrl);
//   var responseData = jsonDecode(response.body);
//   var userData = UsersModel.fromJson(responseData);
//   print(userData.data![0].username);
//   return userData;
// }

  static const dataUrl =
      "https://script.google.com/macros/s/AKfycbyR3lrfE_peVPhRlQVxXsOEuOiGZkFUcTFVf7WUCCgI56Pn-wppWQwrnjhUpVo5z-6Y/exec";
  var baseUrl = Uri.parse(dataUrl);

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [ExpensesForm] parameters
  /// and sends HTTP GET request on [baseUrl]. On successful response, [callback] is called.
  void submitForm(
      ExpensesForm expensesForm, void Function(String) callback) async {
    try {
      await http
          .post(baseUrl, body: expensesForm.toJson())
          .then((response) async {
        if (response.statusCode == 302) {
          // var url = response.headers['location'];
          // var url = response.headers['location'];
          await http.get(baseUrl).then((response) {
            callback(jsonDecode(response.body)['status']);
          });
        } else {
          callback(jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
