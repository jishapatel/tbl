import 'package:flutter/material.dart';

class DialogExample extends StatelessWidget {
  final Function(bool) onEvent;

  const DialogExample({super.key, required this.onEvent});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      actions: <Widget>[
        Center(
          child: Column(
            children: [
              const SizedBox(
                height: 36,
              ),
              const SizedBox(
                width: 192,
                child: Text(
                  "Do you want cancel your reservation?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff002f6c),
                    fontSize: 14,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 34,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  onEvent(true);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffeaeaea),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8, ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        "Cancel booking",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff002f6c),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12,),
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff002f6c),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8, ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        "Go back",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffeaeaea),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
        // TextButton(
        //   style: ButtonStyle(
        //     foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Text('Cancel'),
        // ),
        // TextButton(
        //   style: ButtonStyle(
        //     foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Text('Ok'),
        // )
      ],
    );
  }
}
