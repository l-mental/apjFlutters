import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://<TU_IP>:5000/api'; // Cambia por tu IP

  // ===== Productos =====
  static Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  static Future<dynamic> createProduct(String name, double price, int stock) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'price': price, 'stock': stock}),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al crear producto');
    }
  }

  static Future<void> updateProduct(int id, String name, double price, int stock) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'price': price, 'stock': stock}),
    );
    if (response.statusCode != 200) throw Exception('Error al actualizar');
  }

  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/products/$id'));
    if (response.statusCode != 200) throw Exception('Error al eliminar');
  }

  // ===== Ventas =====
  static Future<void> createSale(int productId, int quantity) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/sales'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'productId': productId, 'quantity': quantity}),
    );
    if (response.statusCode != 201) throw Exception('Error al vender');
  }

  static Future<List<dynamic>> getSales() async {
    final response = await http.get(Uri.parse('$_baseUrl/sales'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar ventas');
    }
  }

  // ===== Estadísticas =====
  static Future<Map<String, dynamic>> getStats() async {
    final response = await http.get(Uri.parse('$_baseUrl/sales/stats'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar stats');
    }
  }
}