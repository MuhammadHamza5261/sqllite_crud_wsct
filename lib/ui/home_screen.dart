// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:sqlite_crud_wsct/data/local/db_helper.dart';
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//
//
//   List<Map<String,dynamic>> allNotes = [
//
//
//   ];
//
//   DbHelper? dbRef;
//
//   @override
//   void initState() {
//     super.initState();
//     dbRef = DbHelper.getInstance();
//     getNotes();
//   }
//
//   void  getNotes() async{
//    allNotes = await  dbRef!.getAllNotes();
//    setState(() {
//
//    });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(
//           onPressed: () async{
//            // bool check = await dbRef!.addNote(
//            //     title: "New Title", desc: "My Descrip");
//            // if(check){
//            //   getNotes();
//            // }
//             showModalBottomSheet(
//                 context: context, builder: (context){
//                    return Container(
//                      padding: const EdgeInsets.all(20),
//                      width: double.infinity,
//                      child: Column(
//                        children: [
//                          const Text('Add Note',style: TextStyle(
//                            fontSize: 20,
//                            fontWeight: FontWeight.bold,
//                          ),),
//                          const SizedBox(
//                            height: 20,
//                          ),
//                          TextFormField(
//                            controller: _titleController,
//                            decoration: InputDecoration(
//                              focusedBorder: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(10),
//                              ),
//                              enabledBorder: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(10)
//                              ),
//                              hintText: 'Title',
//
//                            ),
//                          ),
//                        const  SizedBox(
//                            height: 20,
//                          ),
//                          TextFormField(
//                            maxLines: 4,
//                            controller: _descriptionController,
//                            decoration: InputDecoration(
//                              focusedBorder: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(10),
//                              ),
//                              enabledBorder: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(10)
//                              ),
//                              hintText: 'Description',
//
//                            ),
//                          ),
//                          const  SizedBox(
//                            height: 20,
//                          ),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            children: [
//                              Expanded(
//                                child: OutlinedButton(
//                                  style: OutlinedButton.styleFrom(
//                                      shape: RoundedRectangleBorder(
//                                        borderRadius: BorderRadius.circular(10)
//                                      )
//                          ),
//
//                                  onPressed: (){
//                                    Navigator.pop(context);
//                                  },
//                                  child: const Text('Cancel'),
//                                ),
//                              ),
//                              const SizedBox(
//                                width: 20,
//                              ),
//                              Expanded(
//                                child: OutlinedButton(
//                                  style: OutlinedButton.styleFrom(
//                                    shape: RoundedRectangleBorder(
//                                      side: const BorderSide(
//                                        width: 1,
//                                          color: Colors.black
//                                      ),
//                                      borderRadius: BorderRadius.circular(10)
//                                    )
//                                  ),
//                                    onPressed: () async{
//
//                                     var title = _titleController.text;
//                                     var desc = _descriptionController.text;
//
//                                     if(title.isNotEmpty && desc.isNotEmpty){
//                                     bool check = await  dbRef!.addNote(title: title, desc: desc);
//                                     if(check){
//                                        getNotes();
//                                     }
//
//                                     Navigator.pop(context);
//
//                                     }
//                                     else{
//                                       Flushbar(
//                                         message: 'Please fill the required data!!',
//                                       );
//                                     }
//
//
//
//                                    },
//                                    child: const Text('Add Note'),
//                                ),
//                              ),
//
//                            ],
//                          ),
//
//                        ],
//                      ),
//                    );
//             });
//
//           },
//           label: Text('Add Note'),
//       ),
//       appBar: AppBar(
//
//       ),
//       body: Padding(
//         padding: const    EdgeInsets.symmetric(horizontal: 20,vertical: 15),
//         child: Column(
//           children: [
//             allNotes.isNotEmpty ? ListView.builder(
//
//                  itemCount: allNotes.length,
//                 itemBuilder: (context,index){
//                    return ListTile(
//                      leading: Text(allNotes[index][dbRef!.COLMN_NOTE_SNO.toString()]),
//                      title: Text(allNotes[index][dbRef!.COLMN_NOTE_TITLE]),
//                      subtitle: Text(allNotes[index][dbRef!.COLMN_NOTE_DESC])
//                    );
//
//                 }
//             ): const Center(
//               child: Text('No Notes Yet!!'),
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shape_maker/shape_maker.dart';
import 'package:shape_maker/shape_maker_painter.dart';
import 'package:sqlite_crud_wsct/data/local/db_helper.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<Map<String, dynamic>> allNotes = [];
  DbHelper? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = DbHelper.getInstance();
    getNotes();
  }

  void getNotes() async {
    try {
      allNotes = await dbRef!.getAllNotes();
      setState(() {});
    } catch (e) {
      debugPrint('Error fetching notes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () async {
          showFullScreenBottomSheet(context);
        },
        label: const Text('Add Note',style: TextStyle(
          letterSpacing: 2.2,
          color: Colors.white
        ),),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: const Text('Keep Notes',
          style: TextStyle(
          letterSpacing: 4,
          color: Colors.white
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            allNotes.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: allNotes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),

                      tileColor: Colors.grey.shade300,
                      leading: Stack(
                        alignment: Alignment.center, // Ensures the children are centered
                        children: [
                          const SizedBox(
                            width: 35,
                            height: 35,

                            child: ShapeMaker(

                              bgColor: Colors.deepOrangeAccent,
                              shapeType: ShapeType.hexagon,
                            ),
                          ),
                          Text(
                            allNotes[index][dbRef!.COLMN_NOTE_SNO].toString(),
                            style: const TextStyle(
                              color: Colors.white, // Ensures the text is visible on the shape
                             fontSize: 14
                            ),
                          ),
                        ],
                      ),

                      title: Text(allNotes[index][dbRef!.COLMN_NOTE_TITLE]),
                      subtitle: Text(allNotes[index][dbRef!.COLMN_NOTE_DESC]),
                      trailing: SizedBox(
                        width: 100, // Define width for Row
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                _titleController.text = allNotes[index][dbRef!.COLMN_NOTE_TITLE];
                                _descriptionController.text = allNotes[index][dbRef!.COLMN_NOTE_DESC];

                                showFullScreenBottomSheet(
                                  context,
                                  isUpdate: true,
                                  sno: allNotes[index][dbRef!.COLMN_NOTE_SNO],
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await dbRef!.deleteNote(
                                  sno: allNotes[index][dbRef!.COLMN_NOTE_SNO],
                                );
                                getNotes();
                              },
                              icon: const Icon(
                                Icons.delete_forever_rounded,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
                : const Expanded(
              child: Center(
                child: Text('No Notes Yet!!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFullScreenBottomSheet(BuildContext context, {bool isUpdate = false, int sno = 0}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black38,

      // Light background
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0,sigmaY: 2.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      isUpdate ? 'Update Note' : 'Add Note',
                      style: TextStyle(
                        color: isUpdate ? Colors.green: Colors.deepOrangeAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white
                    ),
                    cursorColor: Colors.white,
                    controller: _titleController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        color: Colors.white
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white
                    ),
                    cursorColor: Colors.white,
                    maxLines: 4,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(

                        borderSide: BorderSide(color:Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        color: Colors.white
                      )
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ), // Pushes buttons to the bottom
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel',style: TextStyle(
                              color: Colors.white
                            ),),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              var title = _titleController.text;
                              var desc = _descriptionController.text;
            
                              if (title.isNotEmpty && desc.isNotEmpty) {
                                bool check = isUpdate
                                    ? await dbRef!.updateNote(
                                  title: title,
                                  description: desc,
                                  sno: sno,
                                )
                                    : await dbRef!.addNote(
                                  title: title,
                                  desc: desc,
                                );
                                if (check) {
                                  getNotes();
                                }
                                Navigator.pop(context);
                              } else {
                                Flushbar(
                                  message: 'Please fill the required data!',
                                  duration: const Duration(seconds: 2),
                                ).show(context);
                              }
                              _titleController.clear();
                              _descriptionController.clear();
                            },
                            child: Text(isUpdate ? 'Update Note' : 'Add Note',style: TextStyle(
                              color: Colors.white
                            ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ),
        );
      },
    );
  }


}

