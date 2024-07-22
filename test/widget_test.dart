// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:thuctap_bai1/main.dart';

void main() {
  List<Customer> customers = [];
  customers.add(Customer('Jack', 23));
  customers.add(Customer('Adam', 27));
  customers.add(Customer('Katherin', 25));

  customers.sort((a, b) => a.age.compareTo(b.age));
  print('Sort by Age: ' + customers.toString());

  customers.sort((a, b) => a.name.compareTo(b.name));
  print('Sort by Name: ' + customers.toString());
}

class Customer {
  String name;
  int age;

  Customer(this.name, this.age);

  @override
  String toString() {
    return '{ ${this.name}, ${this.age} }';
  }
}
