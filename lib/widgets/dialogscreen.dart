import 'package:flutter/material.dart';
import 'package:tbl/base/components/screen_utils/flutter_screenutil.dart';

import '../base/constants/app_widgets.dart';

// class dialogScreen extends StatelessWidget {
//   final Function(String) onEvent;
//
//   const dialogScreen({super.key, required this.onEvent});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'HI '),
//     );
//   }
// }

class MyUpdatePage extends StatefulWidget {
  final Function(String) onEvent;

  //const MyHomePage({super.key, required this.title});
  const MyUpdatePage({super.key, required this.onEvent});

  @override
  State<MyUpdatePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyUpdatePage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _modalBottomSheetMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Scaffold(
              //resizeToAvoidBottomInset: true,
              body: WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              return true;
            },
            child: SingleChildScrollView(
              child: Container(
                height: 350.h,
                color: Colors.white,
                //could change this to Color(0xFF737373),
                //so you don't have to change MaterialApp canvasColor
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.fromLTRB(20, 45, 20, 20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: 'your_mail@mail.com',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 30,
                      child: Text(
                        'Email address',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 47, 108),
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      child: Container(
                        margin: EdgeInsets.only(left: 170),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                ),
                                child: const Text('Cancel',
                                    style: TextStyle(color: Colors.black)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.orange),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(90, 40), // Set the width and height here
                                ),
                              ),
                              child: const Text('Save',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                if (_textEditingController.text.isEmpty ||
                                    checkEmailId(_textEditingController.text) ==
                                        false) {
                                  showMessageBar("Enter valid emailId");
                                } else {
                                  String enteredText =
                                      _textEditingController.text;
                                  widget.onEvent(enteredText);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
        });
  }

  void processText(String text) {
    print(text);
  }
}

bool checkEmailId(String emailId) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(emailId);
  return emailValid;
}
