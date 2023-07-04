import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  int zingerBurgerQuantity;
  int rollParathaQuantity;
  int burgerQuantity;
  int sandwichQuantity;
  int pizzaRollQuantity;
  int mushroomSoupQuantity;

  UserData({
    this.zingerBurgerQuantity = 0,
    this.rollParathaQuantity = 0,
    this.burgerQuantity = 0,
    this.sandwichQuantity = 0,
    this.pizzaRollQuantity = 0,
    this.mushroomSoupQuantity = 0,
  });

  void updateQuantities({
    required int zingerBurgerQuantity,
    required int rollParathaQuantity,
    required int burgerQuantity,
    required int sandwichQuantity,
    required int pizzaRollQuantity,
    required int mushroomSoupQuantity,
  }) {
    this.zingerBurgerQuantity = zingerBurgerQuantity;
    this.rollParathaQuantity = rollParathaQuantity;
    this.burgerQuantity = burgerQuantity;
    this.sandwichQuantity = sandwichQuantity;
    this.pizzaRollQuantity = pizzaRollQuantity;
    this.mushroomSoupQuantity = mushroomSoupQuantity;

    notifyListeners();
  }
}
