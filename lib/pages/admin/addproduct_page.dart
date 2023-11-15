import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/admin.dart';
import 'package:the_best_furniture/models/category.dart';
import 'package:the_best_furniture/models/colors.dart';
import 'package:the_best_furniture/models/productservice.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  String selectedCategory="";
  String selectedColor="";
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
              controller: idController,
              decoration: const InputDecoration(labelText: 'Product ID'),
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Product price'),
            ),
            TextFormField(
              controller: stockController,
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
          StreamBuilder<List<ProductColors>>(
          stream: productService.getColorStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child:  Text('No color available.'));
            }
            return DropdownButton( items: snapshot.data!.map((color) {
                      return DropdownMenuItem<String>(
                        value:  color.name,
                        child: Text(color.name),
                      );
                    }).toList(), onChanged: (String? newValue) {
                      setState(() {
                        selectedColor = newValue!;
                      });
                    },);
          },
            ),
            IconButton(onPressed: (){
              handleImageUpload();
            },icon: const Icon(Icons.upload_file_sharp),),
            ElevatedButton(
              onPressed: (){
                Admin().addProducts(nameController.text, int.parse(priceController.text), selectedCategory, downloadUrl, int.parse(stockController.text),selectedColor);
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
    Reference storageReference = FirebaseStorage.instance.ref().child("images/");
    UploadTask uploadTask = storageReference.putData(bytes);
    await uploadTask.whenComplete(() => null);
    String url = await storageReference.getDownloadURL();
    return url;
  }
}

/*class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              MyAppBar(title: "THE BEST FURNITURE"),
            ],
            body: Row(
              children: [
                Expanded(flex: 4, child: ProductGridSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }
} */