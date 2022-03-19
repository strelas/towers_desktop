import 'dart:collection';

extension QueueExt<T> on Queue<T> {
  Queue<T> copy() {
    return Queue.of(toList());
  }
}

extension ListExt<T> on List<T> {
  List<T> copy() {
    return List.from(this);
  }

  List<S> mapIndexed<S>(S Function(int index, T value) mapper) {
    final result = <S>[];
    for (int i = 0; i<length; i++) {
      result.add(mapper(i, this[i]));
    }
    return result;
  }

  T? firstWhereOrNull(bool Function(T element) tester) {
    for (final element in this) {
      if (tester(element)) {
        return element;
      }
    }
    return null;
  }
}