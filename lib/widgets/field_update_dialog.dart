import 'package:flutter/material.dart';

import '../base/constants/app_widgets.dart';

class TextFieldAlertDialog extends StatefulWidget {
  final Function(String) onEvent;

  const TextFieldAlertDialog({super.key, required this.onEvent});

  @override
  _TextFieldAlertDialogState createState() => _TextFieldAlertDialogState();
}
// class _TextFieldAlertDialogState extends State<TextFieldAlertDialog> {
//   final _textController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.all(10),
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 3000),
//         curve: Curves.easeInOut,
//         transform: Matrix4.translationValues(0, 100, 0),
//         child: Stack(
//           alignment: Alignment.topLeft,
//           children: <Widget>[
//             Container(
//               width: double.infinity,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(0),
//                 color: Colors.white,
//               ),
//               padding: EdgeInsets.fromLTRB(20, 45, 20, 20),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: TextField(
//                   controller: _textController,
//                   decoration: InputDecoration(
//                     hintText: 'your_mail@mail.com',
//                     hintStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 20,
//               left: 30,
//               child: Text(
//                 'Email address',
//                 style: TextStyle(
//                   color: Color.fromARGB(255, 0, 47, 108),
//                   fontSize: 16,
//                   fontStyle: FontStyle.normal,
//                   fontFamily: "Inter",
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 120,
//               child: Container(
//                 margin: EdgeInsets.only(left: 150),
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all<Color>(Colors.white),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(0),
//                             ),
//                           ),
//                         ),
//                         child: const Text('Cancel',
//                             style: TextStyle(color: Colors.black)),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(Colors.orange),
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(0),
//                           ),
//                         ),
//                         fixedSize: MaterialStateProperty.all<Size>(
//                           Size(90, 40), // Set the width and height here
//                         ),
//                       ),
//                       child: const Text('Save',
//                           style: TextStyle(color: Colors.white)),
//                       onPressed: () {
//                         if (_textController.text.isEmpty ||
//                             checkEmailId(_textController.text) == false) {
//                           showMessageBar("Enter valid emailId");
//                         } else {
//                           String enteredText = _textController.text;
//                           widget.onEvent(enteredText);
//                           Navigator.of(context).pop();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _TextFieldAlertDialogState extends State<TextFieldAlertDialog> {
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  double _bottomPadding = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Email addresses"),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Scaffold(
            //resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Container(
                height: 200.0,
                color: Colors.white, //could change this to Color(0xFF737373),
                //so you don't have to change MaterialApp canvasColor
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: TextField(
                          controller: _textController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term',
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add your action here
                        // Call the processText function with the _textEditingController.text value
                        //processText(_textController.text);
                        //Navigator.of(context).pop();
                        if (_textController.text.isEmpty ||
                            checkEmailId(_textController.text) == false) {
                          showMessageBar("Enter valid emailId");
                        } else {
                          String enteredText = _textController.text;
                          widget.onEvent(enteredText);
                          Navigator.of(context).pop();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.orange, width: 2.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

void showTextFieldAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return TextFieldAlertDialog(
        onEvent: (String) {},
      );
    },
  );
}

bool checkEmailId(String emailId) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(emailId);
  return emailValid;
}
