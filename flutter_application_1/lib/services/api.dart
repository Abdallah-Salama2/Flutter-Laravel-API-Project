import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/Models/Category.dart';
import 'package:flutter_application_1/Models/transaction.dart';
import 'package:http/http.dart' as http;

class ApiService {
  late String token;

  final String baseUrl = 'http://10.0.2.2:8000/api/';
  //for edge eb //Uri.parse('http://127.0.0.1:8000/api/categories')

  Future<List<Category>> fetchCategories() async {
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'categories'),

      //assinged variable respne to the url and type of vairable is http.repsonse
    );

    List categories = jsonDecode(response.body);
    // we decoded reponse body into the list of categories

    //now transfer the list i got from response.body to the list of model <Category>

    return categories.map((category) => Category.fromJson(category)).toList();
    //so by the end of transfrom we get list of Category Model and return it as a future
  }

  Future<Category> addCategory(String name) async {
    String uri = baseUrl + 'categories';

    http.Response response = await http.post(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 201) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error happened on create: ${response.statusCode}');
    }
  }

  Future<Category> updateCategory(Category category) async {
    String uri = baseUrl + 'categories/' + category.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({'name': category.name}));

    if (response.statusCode != 200) {
      throw Exception('Error happened on update');
    }

    return Category.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteCategory(id) async {
    String uri = baseUrl + 'categories/' + id.toString();

    http.Response response = await http.delete(Uri.parse(uri));

    if (response.statusCode != 204) {
      throw Exception('Error happened on delete');
    }
  }

  Future<List<Transaction>> fetchTransactions() async {
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'transactions'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    List transactions = jsonDecode(response.body);

    return transactions
        .map((transaction) => Transaction.fromJson(transaction))
        .toList();
  }

  Future<Transaction> addTransaction(
      String amount, String category, String description, String date) async {
    String uri = baseUrl + 'transactions';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({
          'amount': amount,
          'category_id': category,
          'description': description,
          'transaction_date': date
        }));

    if (response.statusCode != 201) {
      throw Exception('Error happened on create');
    }

    return Transaction.fromJson(jsonDecode(response.body));
  }

  Future<Transaction> updateTransaction(Transaction transaction) async {
    String uri = baseUrl + 'transactions/' + transaction.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({
          'amount': transaction.amount,
          'category_id': transaction.categoryId,
          'description': transaction.description,
          'transaction_date': transaction.transactionDate
        }));

    if (response.statusCode != 200) {
      throw Exception('Error happened on update');
    }

    return Transaction.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteTransaction(id) async {
    String uri = baseUrl + 'transactions/' + id.toString();
    http.Response response = await http.delete(
      Uri.parse(uri),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Error happened on delete');
    }
  }

  Future<String> register(String name, String email, String password,
      String passwordConfirm, String deviceName) async {
    String uri = baseUrl + 'auth/register';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirm,
          'device_name': deviceName
        }));

    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      errors.forEach((key, value) {
        value.forEach((element) {
          errorMessage += element + '\n';
        });
      });
      throw Exception(errorMessage);
    }

    // return token
    return response.body;
  }

  Future<String> login(String email, String password, String deviceName) async {
    String uri = baseUrl + 'auth/login';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode(
            {'email': email, 'password': password, 'device_name': deviceName}));

    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      errors.forEach((key, value) {
        value.forEach((element) {
          errorMessage += element + '\n';
        });
      });
      throw Exception(errorMessage);
    }

    // return token
    return response.body;
  }
}
