// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This example shows how to perform a simple animation using the underlying
// render tree.

import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

void main() {
  // We first create a render object that represents a green box.
  RenderBox green = new RenderDecoratedBox(
    decoration: const BoxDecoration(backgroundColor: const Color(0xFF00FF00))
  );
  // Second, we wrap that green box in a render object that forces the green box
  // to have a specific size.
  RenderBox square = new RenderConstrainedBox(
    additionalConstraints: const BoxConstraints.tightFor(width: 200.0, height: 200.0),
    child: green
  );
  // Third, we wrap the sized green square in a render object that applies rotation
  // transform before painting its child. Each frame of the animation, we'll
  // update the transform of this render object to cause the green square to
  // spin.
  RenderTransform spin = new RenderTransform(
    transform: new Matrix4.identity(),
    alignment: const FractionalOffset(0.5, 0.5),
    child: square
  );
  // Finally, we center the spinning green square...
  RenderBox root = new RenderPositionedBox(
    alignment: const FractionalOffset(0.5, 0.5),
    child: spin
  );
  // and attach it to the window.
  new RenderingFlutterBinding(root: root);

  // To make the square spin, we use an animation that repeats every 1800
  // milliseconds.
  AnimationController animation = new AnimationController(
    duration: const Duration(milliseconds: 1800)
  )..repeat();
  // The animation will produce a value between 0.0 and 1.0 each frame, but we
  // want to rotate the square using a value between 0.0 and math.PI. To change
  // the range of the animation, we use a Tween.
  Tween<double> tween = new Tween<double>(begin: 0.0, end: math.PI);
  // We add a listener to the animation, which will be called every time the
  // animation ticks.
  animation.addListener(() {
    // This code runs every tick of the animation and sets a new transform on
    // the "spin" render object by evaluating the tween on the current value
    // of the animation. Setting this value will mark a number of dirty bits
    // inside the render tree, which cause the render tree to repaint with the
    // new transform value this frame.
    spin.transform = new Matrix4.rotationZ(tween.evaluate(animation));
  });
}
