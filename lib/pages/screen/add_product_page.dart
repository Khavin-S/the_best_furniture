import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/admin.dart';
import 'package:the_best_furniture/models/category.dart';
import 'package:the_best_furniture/models/colors.dart';
import 'package:the_best_furniture/models/productservice.dart';
import 'package:the_best_furniture/pages/screen/add_category_page.dart';
import 'package:the_best_furniture/pages/screen/add_color_page.dart';
import 'package:the_best_furniture/providers/navigation.dart';
import 'package:the_best_furniture/widgets/custom_button.dart';
import 'package:the_best_furniture/widgets/custom_textfield.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});
  FormFieldSection form = FormFieldSection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormFieldSection(),
              DropdownCategorySection(),
              const SizedBox(
                height: 20,
              ),
              const DropdownColorSection(),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              ImageSection(),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  child: MyButton(
                      text: 'Add product',
                      onPressed: () {
                       Admin().addProducts(
                            FormFieldSection.nameController.text,
                            FormFieldSection.descriptionController.text,
                            int.parse(FormFieldSection.priceController.text),
                            DropdownCategorySection.selectedCategory,
                            ImageSection.downloadUrl,
                            int.parse(FormFieldSection.stockController.text),
                            DropdownColorSection.selectedColor);
                      },
                      buttonColor: Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}

class FormFieldSection extends StatelessWidget {
  FormFieldSection({super.key});
  static TextEditingController nameController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: double.infinity,
            child: MyTextField(
                hintText: 'Product name', controller: nameController)),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            width: double.infinity,
            child: MyTextField(
                height: 100,
                hintText: 'Product price',
                controller: priceController)),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            width: double.infinity,
            child: MyTextField(
                height: 100,
                hintText: 'Product description',
                controller: descriptionController)),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            width: double.infinity,
            child: MyTextField(
                hintText: 'Product stock', controller: stockController)),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class DropdownCategorySection extends StatefulWidget {
  DropdownCategorySection({super.key});
  ProductService productService = ProductService();
  static String selectedCategory = '';

  @override
  State<DropdownCategorySection> createState() =>
      _DropdownCategorySectionState();
}

class _DropdownCategorySectionState extends State<DropdownCategorySection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StreamBuilder<List<Categories>>(
          stream: widget.productService.getCategoryStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No categories available.'));
            }
            return DropdownButton(
              items: snapshot.data!.map((category) {
                return DropdownMenuItem<String>(
                  value: category.name,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  DropdownCategorySection.selectedCategory = newValue!;
                });
              },
            );
          },
        ),
        IconButton(onPressed: (){
          Navigation.goto(context, const AddCategoryPage());
        }, icon: const Icon(Icons.add))
      ],
    );
  }
}

class DropdownColorSection extends StatefulWidget {
  static String selectedColor = '';

  const DropdownColorSection({super.key});

  @override
  State<DropdownColorSection> createState() => _DropdownColorSectionState();
}

class _DropdownColorSectionState extends State<DropdownColorSection> {
  ProductService productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
              return const Center(child: Text('No colors available.'));
            }
            return DropdownButton(
              
              items: snapshot.data!.map((color) {
                return DropdownMenuItem<String>(
                  value: color.name,
                  child: Text(color.name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  DropdownColorSection.selectedColor = newValue!;
                });
              },
            );
          },
        ),
        IconButton(onPressed: (){
          Navigation.goto(context, AddColorPage());
        }, icon: const Icon(Icons.add))
      ],
    );
  }
}

class ImageSection extends StatefulWidget {
  static String downloadUrl = "";
  ImageSection({super.key});

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              handleImageUpload();
            },
            icon: const Icon(Icons.upload_file_sharp)),
      ],
    );
  }

  Future<void> handleImageUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      Uint8List? bytes = result.files.first.bytes;
      String imageName = result.files.single.name;
      String url = await uploadImage(bytes!, imageName);
      setState(() {
        ImageSection.downloadUrl = url;
      });
    }
  }

  Future<String> uploadImage(Uint8List bytes, String imageName) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child("images/$imageName");
    UploadTask uploadTask = storageReference.putData(bytes);
    await uploadTask.whenComplete(() => null);
    String url = await storageReference.getDownloadURL();
    return url;
  }
}
