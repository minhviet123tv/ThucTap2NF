import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thuctap_bai1/main/main.dart';

void main() {
  // List<Customer> customers = [];
  // customers.add(Customer('Jack', 23));
  // customers.add(Customer('Adam', 27));
  // customers.add(Customer('Katherin', 25));
  //
  // customers.sort((a, b) => a.age.compareTo(b.age));
  // print('Sort by Age: ' + customers.toString());
  //
  // customers.sort((a, b) => a.name.compareTo(b.name));
  // print('Sort by Name: ' + customers.toString());

  final now = DateTime.now();
  print(now.hour.toString());

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
