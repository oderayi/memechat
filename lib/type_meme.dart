// Copyright 2017, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';

import 'platform_adaptive.dart';

class TypeMemeRoute extends MaterialPageRoute<String> {
  TypeMemeRoute(File imageFile)
      : super(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return new TypeMemeDialog(imageFile: imageFile);
            });
}

class TypeMemeDialog extends StatefulWidget {
  final File imageFile;

  TypeMemeDialog({this.imageFile});

  @override
  State<StatefulWidget> createState() => new TypeMemeDialogState();
}

// Represents the states of typing text onto an image to make a meme.
class TypeMemeDialogState extends State<TypeMemeDialog> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PlatformAdaptiveAppBar(
        title: new Text("New meme"),
        platform: Theme.of(context).platform,
        actions: <Widget>[
          new FlatButton(
            child: new Text('SEND'),
            onPressed: () => Navigator.pop(context, _text),
          ),
        ],
      ),
      body: new Column(
        children: <Widget>[
          new Stack(
            children: [
              new Image.file(widget.imageFile, width: 250.0),
              new Text(_text, style: const TextStyle(fontFamily: 'Impact')),
            ],
            alignment: FractionalOffset.topCenter,
          ),
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 16.0),
            child: new TextField(
              decoration: const InputDecoration(hintText: 'Make yo meme'),
              onChanged: (String text) {
                setState(() {
                  _text = text;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
