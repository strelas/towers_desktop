
import 'package:flutter_test/flutter_test.dart';
import 'package:towers_desktop/entity/move.dart';

void main() {
  test('move hashcode and equals test', () {
    const actual = Move(1, 2);
    const equal = Move(1, 2);
    expect(actual, equal);
    expect(actual.hashCode, equal.hashCode);
    expect(actual.toString(), equal.toString());

    const notEqual1 = Move(1, 3);
    const notEqual2 = Move(0, 2);
    const notEqual3 = Move(2, 3);

    expect(actual == notEqual1, false);
    expect(actual == notEqual2, false);
    expect(actual == notEqual3, false);
  });
}