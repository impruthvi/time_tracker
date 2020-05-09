import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'platform_widgets.dart';

class PlatformAlertDialog extends PlatFormWidgets {
  PlatformAlertDialog({
    @required this.title,
    @required this.content,
    @required this.defaultActionText,
    this.cancelActionText
  })  : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  final String title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => this,
          )
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
            barrierDismissible: false
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final actiom = <Widget>[];
    if(cancelActionText != null){
      actiom.add(
          PlatformAlertDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          )
      );
    }
    actiom.add(
      PlatformAlertDialogAction(
        child: Text(defaultActionText),
        onPressed: () => Navigator.of(context).pop(true),
      )
    );
    return actiom;
  }
}

class PlatformAlertDialogAction extends PlatFormWidgets {
  PlatformAlertDialogAction({this.onPressed, this.child});

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
