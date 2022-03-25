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
}