
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import '../model/todo.dart';
class ToDoItem extends StatelessWidget {

  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem ({Key? key, required this.todo, this.onToDoChanged, this.onDeleteItem}) : super (key: key);

  @override
  Widget build (BuildContext context) {
   return Container(
       margin: EdgeInsets.only(bottom: 25,) ,
       child: ListTile(
     onTap: () {
       //print('Clicked on ToDo item.');
       onToDoChanged(todo);
     },
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(20),
       ),
     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical:5,),
     tileColor: Colors.white,
     leading:  Icon(todo.isDone? Icons.check_box : Icons.check_box_outline_blank
       ,color: tdBlue,),
     title:  Text(
       todo.todoText!,
       style: TextStyle(fontSize: 16 , color: tdBlack , decoration: todo.isDone? TextDecoration.lineThrough: null,),),
     trailing: Container(
       padding: EdgeInsets.all(0),
       margin: const EdgeInsets.symmetric(vertical: 12),
       width: 35, height: 30,decoration: BoxDecoration(
       color: tdRed,
       borderRadius: BorderRadius.circular(15),
     ),
     child: IconButton(
       color:Colors.white,
       iconSize: 18,
       icon: const Icon(Icons.delete),
       onPressed: () {
         //print('Clicked on delete icon.');
         onDeleteItem(todo.id);
       },
     ),
     ),
   ));
  }
}