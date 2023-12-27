import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_first_app/models/category.dart';
import 'package:my_first_app/models/transaction.dart';

class ApiService {
  late String token;

  ApiService(String token) {
    this.token = token;
  }

  final String baseUrl = 'http://10.0.2.2:8000/api/';

  Future<List<Category>> fetchCategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse(baseUrl + 'categories'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Parse the response body as a string
        String? responseBody = response.body;

        // Check if the response body is not null and not empty
        if (responseBody != null && responseBody.isNotEmpty) {
          // Decode the JSON response
          List<dynamic> jsonResponse = jsonDecode(responseBody);

          // Ensure that jsonResponse is a list
          if (jsonResponse is List) {
            // Map each element to a Category object
            List<Category> categories = jsonResponse
                .map((category) => Category.fromJson(category))
                .toList();

            // Return the list of categories
            return categories;
          } else {
            // Handle the case where the JSON response is not a list
            print(
                'Unexpected JSON format. Expected a list under "categories".');
            return [];
          }
        } else {
          // Handle the case where the response body is empty or null
          print('Empty or null response body.');
          return [];
        }
      } else {
        // Handle non-200 status code if needed
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
        print(response.body);
        return [];
      }
    } catch (e) {
      // Handle exceptions during the HTTP request
      print('Error during HTTP request: $e');
      return [];
    }
  }

  Future<Category> addCategory(String name) async {
    String uri = baseUrl + 'categories';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'name': name}));

    if (response.statusCode != 201) {
      throw Exception('Error happened on create');
    }

    return Category.fromJson(jsonDecode(response.body));
  }

  Future<Category> updateCategory(Category category) async {
    String uri = baseUrl + 'categories/' + category.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'name': category.name}));

    if (response.statusCode != 200) {
      throw Exception('Error happened on update');
    }

    return Category.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteCategory(id) async {
    String uri = baseUrl + 'categories/' + id.toString();
    http.Response response = await http.delete(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Error happened on delete');
    }
  }

  Future<List<Transaction>> fetchTransactions() async {
    try {
      http.Response response = await http.get(
        Uri.parse(baseUrl + 'transactions'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Parse the response body as a string
        String? responseBody = response.body;

        // Check if the response body is not null and not empty
        if (responseBody != null && responseBody.isNotEmpty) {
          // Decode the JSON response
          List<dynamic> jsonResponse = jsonDecode(responseBody);

          // Ensure that jsonResponse is a list
          if (jsonResponse is List) {
            // Map each element to a Transaction object
            List<Transaction> transactions = jsonResponse
                .map((transaction) => Transaction.fromJson(transaction))
                .toList();

            // Return the list of transactions
            return transactions;
          } else {
            // Handle the case where the JSON response is not a list
            print(
                'Unexpected JSON format. Expected a list under "transactions".');
            return [];
          }
        } else {
          // Handle the case where the response body is empty or null
          print('Empty or null response body.');
          return [];
        }
      } else {
        // Handle non-200 status code if needed
        print(
            'Failed to fetch transactions. Status code: ${response.statusCode}');
        print(response.body);

        return [];
      }
    } catch (e) {
      // Handle exceptions during the HTTP request
      print('Error during HTTP request: $e');
      return [];
    }
  }

  Future<Transaction> addTransaction(
      String amount, String category, String description, String date) async {
    String uri = baseUrl + 'transactions';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
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
    print(response.body);

    return Transaction.fromJson(jsonDecode(response.body));
  }

  Future<Transaction> updateTransaction(Transaction transaction) async {
    String uri = baseUrl + 'transactions/' + transaction.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
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
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
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
          'Content-Type': 'application/json',
          'Accept': 'application/json',
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
          'Content-Type': 'application/json',
          'Accept': 'application/json',
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
