import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/admin.dart';
import 'package:the_best_furniture/widgets/custom_button.dart';
import 'package:the_best_furniture/widgets/custom_textfield.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController categoryController = TextEditingController();
    TextEditingController sloganController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add category'),
      ),
      body: Padding(

        padding: const EdgeInsets.all(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: MyTextField(
                  hintText: 'Category name', controller: categoryController),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                            width: double.infinity,

              child: MyTextField(hintText: 'Category Slogan', controller: sloganController)),
            const SizedBox(
              height: 20,
            ),
            MyButton(
                text: 'Add catogory',
                onPressed: () {
                  Admin().addCategory(
                      categoryController.text, sloganController.text);
                },
                buttonColor: Colors.black)
          ],
        ),
      ),
    );
  }
}
