import 'package:collection/collection.dart';

extension InsertBetweenElements<T> on List<T> {
  List<T> insertBetweenElements(T Function() elementFactory) {
    if (length < 2) {
      return this;
    }

    final List<T> newList = map((T element) => <T>[element, elementFactory()]).expand((List<T> pair) => pair).toList();
    newList.removeLast();

    return newList;
  }
}

extension ContainsDate on List<DateTime> {
  bool containsDate(DateTime element) =>
      firstWhereOrNull(
        (DateTime date) => date.year == element.year && date.month == element.month && date.day == element.day,
      ) !=
      null;
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final Set<dynamic> ids = <dynamic>{};
    final List<E> list = inplace ? this : List<E>.from(this);
    list.retainWhere((E element) => ids.add(id != null ? id(element) : element as Id));
    return list;
  }
}
