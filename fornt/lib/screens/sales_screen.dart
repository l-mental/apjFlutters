import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late Future<List<dynamic>> futureProducts;
  int? _selectedProductId;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService.getProducts();
  }

  Future<void> _registerSale() async {
    if (_selectedProductId == null) return;

    try {
      await ApiService.createSale(_selectedProductId!, _quantity);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Venta registrada!')),
      );
      setState(() {
        _quantity = 1;
        _selectedProductId = null;
      });
      // Recargar productos para actualizar stock
      futureProducts = ApiService.getProducts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Venta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<List<dynamic>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No hay productos');
                } else {
                  return DropdownButtonFormField<int>(
                    value: _selectedProductId,
                    hint: Text('Selecciona un producto'),
                    items: snapshot.data!.map((product) {
                      return DropdownMenuItem<int>(
                        value: product['id'],
                        child: Text('${product['name']} (Stock: ${product['stock']})'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedProductId = value);
                    },
                  );
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
              initialValue: _quantity.toString(),
              onChanged: (value) {
                setState(() => _quantity = int.tryParse(value) ?? 1);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerSale,
              child: Text('Registrar Venta'),
            ),
          ],
        ),
      ),
    );
  }
}