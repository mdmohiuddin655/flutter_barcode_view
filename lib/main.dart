/*
 * Copyright (C) 2020, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';

import 'barcode.dart';
import 'barcode_conf.dart';
import 'barcode_info.dart';
import 'code.dart';
import 'settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BarcodeConf conf = BarcodeConf();

  @override
  Widget build(BuildContext context) {
    const title = 'Barcode Demo';

    return const MaterialApp(
      title: title,
      home: _Home(title),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home(this.title);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  final BarcodeConf conf = BarcodeConf();

  @override
  void initState() {
    conf.addListener(confListener);
    super.initState();
  }

  @override
  void dispose() {
    conf.removeListener(confListener);
    super.dispose();
  }

  void confListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scrollbar(
        child: width < 800
            ? ListView(
                children: <Widget>[
                  Settings(conf: conf),
                  BarcodeView(conf: conf),
                  BarcodeInfo(conf: conf),
                  Code(conf: conf),
                ],
              )
            : Row(
                children: [
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        Settings(conf: conf),
                        Code(conf: conf),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: ListView(
                      children: <Widget>[
                        BarcodeView(conf: conf),
                        BarcodeInfo(conf: conf),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
