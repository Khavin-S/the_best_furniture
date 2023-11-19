import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/admin.dart';
import 'package:the_best_furniture/widgets/custom_button.dart';
import 'package:the_best_furniture/widgets/custom_textfield.dart';

class AddColorPage extends StatelessWidget {
  const AddColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController colorController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add color'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                            width: double.infinity,

              child: MyTextField(
                  hintText: 'Color name', controller: colorController),
            ),
            const SizedBox(
              height: 20,
            ),
        
            MyButton(
                text: 'Add color',
                onPressed: () {
                  Admin().addColors(
                      colorController.text);
                },
                buttonColor: Colors.black)
          ],
        ),
      ),
    );
  }
}
