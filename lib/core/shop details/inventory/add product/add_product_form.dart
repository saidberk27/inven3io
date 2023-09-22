import 'package:flutter/material.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Form Örneği'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bu alan boş bırakılamaz.';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
              decoration: InputDecoration(
                labelText: 'Adınız',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // _name değişkeni formdan alınan adı içerir, burada işleyebilirsiniz
                  print('Adınız: $_name');
                }
              },
              child: Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
