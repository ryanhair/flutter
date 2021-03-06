// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  test('Verify that a BottomSheet can be rebuilt with ScaffoldFeatureController.setState()', () {
    testWidgets((WidgetTester tester) {
      final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      PersistentBottomSheetController<Null> bottomSheet;
      int buildCount = 0;

      tester.pumpWidget(new MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) {
            return new Scaffold(
              key: scaffoldKey,
              body: new Center(child: new Text('body'))
            );
          }
        }
      ));

      bottomSheet = scaffoldKey.currentState.showBottomSheet/*<Null>*/((_) {
        return new Builder(
          builder: (_) {
            buildCount += 1;
            return new Container(height: 200.0);
          }
        );
      });

      tester.pump();
      expect(buildCount, equals(1));

      bottomSheet.setState((){ });
      tester.pump();
      expect(buildCount, equals(2));
    });
  });

}
