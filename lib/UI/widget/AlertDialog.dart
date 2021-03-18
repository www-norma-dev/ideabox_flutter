import 'package:flutter/cupertino.dart';

class AlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Title'),
      actions: [
        CupertinoDialogAction(child: Text("non")),
        CupertinoDialogAction(child: Text("yes")),
      ],
    );
  }
}
