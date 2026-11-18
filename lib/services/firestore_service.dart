import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo.dart';

class FirestoreService {
  final CollectionReference _todoCollection = FirebaseFirestore.instance.collection('todos');

  // create
  Future<void> addTodo(String taskName) async {
    final newTodo = Todo(id: '', task: taskName, isDone: false);
    await _todoCollection.add(newTodo.toMap());
  }

  // READ
  Stream<List<Todo>> getTodos() {
    return _todoCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => 
        snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList());
  }

  // UPDATE
  Future<void> updateTodoStatus(String id, bool isDone) async {
    await _todoCollection.doc(id).update({'isDone': isDone});
  }

  // DELETE
  Future<void> deleteTodo(String id) async {
    await _todoCollection.doc(id).delete();
  }

  
}