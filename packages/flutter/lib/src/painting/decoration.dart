// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'basic_types.dart';
import 'edge_insets.dart';

export 'edge_insets.dart' show EdgeInsets;

// This group of classes is intended for painting in cartesian coordinates.

abstract class Decoration {
  const Decoration();
  bool debugAssertValid() => true;
  EdgeInsets get padding => null;
  Decoration lerpFrom(Decoration a, double t) => this;
  Decoration lerpTo(Decoration b, double t) => b;
  bool hitTest(Size size, Point position) => true;
  bool get needsListeners => false;
  void addChangeListener(VoidCallback listener) { assert(false); }
  void removeChangeListener(VoidCallback listener) { assert(false); }
  BoxPainter createBoxPainter();

  @override
  String toString([String prefix = '']) => '$prefix$runtimeType';
}

abstract class BoxPainter { // ignore: one_member_abstracts
  void paint(Canvas canvas, Rect rect);
}
