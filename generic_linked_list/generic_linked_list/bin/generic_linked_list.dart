/// Node class representing an element in the linked list.

class Node<T> {
  T data;
  Node<T>? next;

  Node(this.data, this.next);
}

/// A generic singly linked list class.
class LinkedList<T> {
  Node<T>? head;
  int _length = 0;

  /// Returns the number of elements in the list
  int get length => _length;

  /// Adds [value] to the end of the list.
  void add(T value) {
    if (head == null) {
      head = Node(value, null);
    } else {
      Node<T> current = head!;
      while (current.next != null) {
        current = current.next!;
      }
      current.next = Node(value, null);
    }
    _length++;
  }

  /// Inserts [value] at the given [index].
  void insert(int index, T value) {
    if (index < 0 || index > _length) {
      throw RangeError('Index out of bounds');
    }

    if (index == 0) {
      head = Node(value, head);
    } else {
      Node<T> current = head!;
      for (int i = 0; i < index - 1; i++) {
        current = current.next!;
      }
      current.next = Node(value, current.next);
    }
    _length++;
  }

  /// Removes and returns the element at [index].
  T removeAt(int index) {
    if (index < 0 || index >= _length) {
      throw RangeError('Index out of bounds');
    }

    T removedValue;
    if (index == 0) {
      removedValue = head!.data;
      head = head!.next;
    } else {
      Node<T> current = head!;
      for (int i = 0; i < index - 1; i++) {
        current = current.next!;
      }
      removedValue = current.next!.data;
      current.next = current.next!.next;
    }
    _length--;
    return removedValue;
  }

  /// Returns `true` if [value] is found in the list.

  bool contains(T value) {
    Node<T>? current = head;
    while (current != null) {
      if (current.data == value) return true;
      current = current.next;
    }
    return false;
  }

  /// Returns the index of the first occurrence of [value],
  /// or -1 if not found.
  int indexOf(T value) {
    Node<T>? current = head;
    int index = 0;
    while (current != null) {
      if (current.data == value) return index;
      current = current.next;
      index++;
    }
    return -1;
  }

  /// Clears the entire list.
  void clear() {
    head = null;
    _length = 0;
  }

  /// Provides read access to element at [index].

  T operator [](int index) {
    if (index < 0 || index >= _length) {
      throw RangeError('Index out of bounds');
    }

    Node<T> current = head!;
    for (int i = 0; i < index; i++) {
      current = current.next!;
    }
    return current.data;
  }

  /// Provides write access to element at [index].

  void operator []=(int index, T value) {
    if (index < 0 || index >= _length) {
      throw RangeError('Index out of bounds');
    }

    Node<T> current = head!;
    for (int i = 0; i < index; i++) {
      current = current.next!;
    }
    current.data = value;
  }

  /// Concatenates this list with [other] and returns a new list.

  LinkedList<T> operator +(LinkedList<T> other) {
    LinkedList<T> result = LinkedList<T>();

    Node<T>? current = head;
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }

    current = other.head;
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }

    return result;
  }

  /// Returns a new list with the first occurrence of [value] removed.

  LinkedList<T> operator -(T value) {
    LinkedList<T> result = LinkedList<T>();
    bool removed = false;

    Node<T>? current = head;
    while (current != null) {
      if (!removed && current.data == value) {
        removed = true;
        current = current.next;
        continue;
      }
      result.add(current.data);
      current = current.next;
    }

    return result;
  }

  /// Applies the given [action] to each element in the list.

  void forEach(void Function(T) action) {
    Node<T>? current = head;
    while (current != null) {
      action(current.data);
      current = current.next;
    }
  }

  /// Returns a new [LinkedList] containing the results of applying [transform] to each element.

  LinkedList<S> map<S>(S Function(T) transform) {
    LinkedList<S> result = LinkedList<S>();
    Node<T>? current = head;
    while (current != null) {
      result.add(transform(current.data));
      current = current.next;
    }
    return result;
  }

  /// Returns a new [LinkedList] containing only the elements that satisfy [test].

  LinkedList<T> where(bool Function(T) test) {
    LinkedList<T> result = LinkedList<T>();
    Node<T>? current = head;
    while (current != null) {
      if (test(current.data)) {
        result.add(current.data);
      }
      current = current.next;
    }
    return result;
  }

  @override
  String toString() {
    if (head == null) return 'LinkedList: []';

    StringBuffer buffer = StringBuffer('LinkedList: [');
    Node<T>? current = head;
    while (current != null) {
      buffer.write(current.data);
      if (current.next != null) buffer.write(', ');
      current = current.next;
    }
    buffer.write(']');
    return buffer.toString();
  }
}
