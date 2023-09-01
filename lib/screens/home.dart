import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/widgets/todo_item.dart';


class Home extends StatefulWidget {
   Home ({Key? key}): super (key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList=ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController= TextEditingController();

  @override
   void initState () {
    _foundToDo=todoList;
    super.initState();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold (
      backgroundColor: tdBGColor,
        //refactor extract method
        appBar: buildAppBar(),

      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
            child: Column(
              children: [ searchBox(), Expanded(
                child: ListView(
                  children: [Container(
                    margin: EdgeInsets.only(top:50, bottom:20,),
                    child:  const Text("All ToDos" ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,),),
                  ),
//son eklenen nor en üstter. reverse edildi.
            for(ToDo todo in _foundToDo.reversed)
            ToDoItem(todo: todo,
            onToDoChanged: _handleToDoChange,
            onDeleteItem: _deleteToDoItem,),
            ],
                ),
              )

            ],),

    ),
          Align(alignment: Alignment.bottomCenter,
          child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(bottom:17, right: 18, left: 15,),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration:  BoxDecoration(
                      color: Colors.pink,
                      boxShadow: const [BoxShadow(
                        color: Colors.green,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),]
                    ,
              borderRadius:BorderRadius.circular(10),
            ),
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                  hintText: 'Add a new todo item',
                  border: InputBorder.none,
                ),
              ),
            ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, right: 20,),
              child: ElevatedButton(
                child: Text('+', style: TextStyle(fontSize: 40,)),
              onPressed: () {
                  _addToDoItem(_todoController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tdBlue,
                minimumSize: Size(65, 65),
                elevation:10,
              )),

            ),
          ],)
            ,)
        ],//bracket []
      ),
    ); // Scaffold
  }

  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id){
    setState(() {
      todoList.removeWhere((item) =>item.id==id);
    });
  }

  void _addToDoItem(String toDo){
    setState(() {
      todoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo,),);
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyWord){
    List<ToDo> results= [];
    if(enteredKeyWord.isEmpty) {
      results=todoList;
    } else{
      results=todoList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyWord.toLowerCase())).toList();
    }

    setState(() {
      _foundToDo=results;
    });
  }

  Widget searchBox(){
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(20) ),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding : EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search, color: tdBlack, size:20,),
                prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle:TextStyle(color: tdGrey),
              ),
            ),
          );

  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: Row( mainAxisAlignment:MainAxisAlignment.spaceBetween, children: [const Icon(Icons.menu, color: tdBlack, size:30,),Container(height:40,width:40, child: ClipRRect(borderRadius:BorderRadius.circular(15),child: Image.asset('assets/profile.jpg'),)),],),
  );
  }
}