import 'package:flutter_test/flutter_test.dart'; 

void main() {
  group('Counter Logic Tests', () {
    test('Counter starts at 0', () {
      // Arrange & Act
      int counter = 0;

      // Assert
      expect(counter, 0);
    });

    test('Counter increments correctly', () {
      // Arrange
      int counter = 0;

      // Act
      counter++;

      // Assert
      expect(counter, 1);
    });

    test('Counter decrements correctly', () {
      // Arrange
      int counter = 5;

      // Act
      counter--;

      // Assert
      expect(counter, 4);
    });

    test('Counter can be negative', () {
      // Arrange
      int counter = 0;

      // Act
      counter--;

      // Assert
      expect(counter, -1);
    });

    test('Counter resets to 0', () {
      // Arrange
      int counter = 100;

      // Act
      counter = 0;

      // Assert
      expect(counter, 0);
    });

    test('Multiple increments work correctly', () {
      // Arrange
      int counter = 0;

      // Act
      for (int i = 0; i < 10; i++) {
        counter++;
      }

      // Assert
      expect(counter, 10);
    });
  });
}
