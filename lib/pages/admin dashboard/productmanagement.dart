import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/classes/admin.dart';
import 'package:the_best_furniture/classes/category.dart';
import 'package:the_best_furniture/classes/productservice.dart';
import 'package:the_best_furniture/others/widegts.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  String selectedCategory="chairs";
  String? downloadUrl;
  @override
  Widget build(BuildContext context) {
        ProductService productService = ProductService();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Product ID'),
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Product price'),
            ),
            TextFormField(
              controller: _stockController,
              decoration: const InputDecoration(labelText: 'Product stock'),
              keyboardType: TextInputType.number,
            ),
             StreamBuilder<List<Categories>>(
          stream: productService.getCategoryStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child:  Text('No category available.'));
            }
            return DropdownButton( items: snapshot.data!.map((category) {
                      return DropdownMenuItem<String>(
                        value:  category.name,
                        child: Text(category.name),
                      );
                    }).toList(), onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },);
          },
            ),
            IconButton(onPressed: (){
              handleImageUpload();
            },icon: const Icon(Icons.upload_file_sharp),),
            ElevatedButton(
              onPressed: (){
                Admin().addProducts(_nameController.text, int.parse(_priceController.text), selectedCategory, downloadUrl, int.parse(_stockController.text));
              },
              child: const Text('Add or Update products'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  Future<void> handleImageUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      Uint8List? bytes = result.files.first.bytes;
      String url = await uploadImage(bytes!);
      setState(() {
        downloadUrl = url;
      });
    }
  }

  Future<String> uploadImage(Uint8List bytes) async {
    Reference storageReference = FirebaseStorage.instance.ref().child("images/image.jpg");
    UploadTask uploadTask = storageReference.putData(bytes);
    await uploadTask.whenComplete(() => null);
    String url = await storageReference.getDownloadURL();
    return url;
  }
}