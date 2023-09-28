import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreDocumentModel {
  final String id;
  FirestoreDocumentModel(this.id);
  FirestoreDocumentModel.fromFirestoreDocument(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id;

  Map<String, dynamic> toMap();
}

class FirestoreCrudOperations<T extends FirestoreDocumentModel> {
  FirestoreCrudOperations(
    this._collectionName,
    this.fromFirestore,
  ) {
    _collection = FirebaseFirestore.instance.collection(_collectionName);
    _collectionWithConverter = _collection.withConverter<T>(
        fromFirestore: (_, __) => fromFirestore(_),
        toFirestore: (_, __) => _.toMap());
  }

  final T Function(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) fromFirestore;
  final String _collectionName;
  late final CollectionReference<T> _collectionWithConverter;
  late final CollectionReference<Map<String, dynamic>> _collection;

  CollectionReference<T> get collectionWithConverter =>
      _collectionWithConverter;

  Stream<List<T>> listen([Query<T>? query]) {
    final collection = query ?? _collectionWithConverter;
    return collection
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  Future<List<T>> getAll() async {
    final result = await _collectionWithConverter.get();
    return result.docs.map((e) => e.data()).toList();
  }

  Future<T> add(T data) async {
    await _collectionWithConverter.doc(data.id).set(data);
    return data;
  }

  Future<void> delete(String id) async {
    await _collectionWithConverter.doc(id).delete();
  }

  Future<void> update(
    T data,
  ) async {
    await _collectionWithConverter.doc(data.id).update(data.toMap());
  }

  Future<T?> getOne(
    String id,
  ) async {
    final get = await _collectionWithConverter.doc(id).get();
    return get.data();
  }

  /// Create a new unique id if not exists and return it
  Future<String> newId() async {
    return _collectionWithConverter.doc().id;
  }
}
