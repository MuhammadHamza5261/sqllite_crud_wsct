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
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_crud_wsct/data/local/db_helper.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return getBottomSheetWidget(isUpdate: false);
            },
          );
        },
        label: const Text('Add Note'),
      ),
      appBar: AppBar(
        title: const Text('Notes'),
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
                  return ListTile(
                    leading: Text(
                      allNotes[index][dbRef!.COLMN_NOTE_SNO].toString(),
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
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  _titleController.text = allNotes[index][dbRef!.COLMN_NOTE_TITLE];
                                  _descriptionController.text = allNotes[index][dbRef!.COLMN_NOTE_DESC];
                                  return getBottomSheetWidget(
                                    isUpdate: true,
                                    sno: allNotes[index][dbRef!.COLMN_NOTE_SNO],
                                  );
                                },
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
                  );
                },
              ),
            )
                : const Expanded( // Wrap in Expanded for proper layout
              child: Center(
                child: Text('No Notes Yet!!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                isUpdate ? 'Update Note' : 'Add Note',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Title',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines: 4,
              controller: _descriptionController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Description',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.black),
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
                    child: Text(isUpdate ? 'Update Note' : 'Add Note'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

