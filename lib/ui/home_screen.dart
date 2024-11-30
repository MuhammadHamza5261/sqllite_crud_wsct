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


  List<Map<String,dynamic>> allNotes = [


  ];

  DbHelper? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = DbHelper.getInstance();
    getNotes();
  }

  void  getNotes() async{
   allNotes = await  dbRef!.getAllNotes();
   setState(() {

   });
  }


  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async{
           // bool check = await dbRef!.addNote(
           //     title: "New Title", desc: "My Descrip");
           // if(check){
           //   getNotes();
           // }
            showModalBottomSheet(
                context: context, builder: (context){
                   return Container(
                     width: double.infinity,
                     child: Column(
                       children: [
                         Text('Add Note',style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),),
                         SizedBox(
                           height: 20,
                         ),
                         TextFormField(
                           controller: _titleController,
                           decoration: InputDecoration(
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10)
                             ),
                             hintText: 'Title',

                           ),
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         TextFormField(
                           maxLines: 4,
                           controller: _descriptionController,
                           decoration: InputDecoration(
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10)
                             ),
                             hintText: 'Description',

                           ),
                         ),
                         Row(
                           children: [
                             Expanded(
                               child: OutlinedButton(
                                 onPressed: (){
                                   Navigator.pop(context);
                                 },
                                 child: const Text('Cancel'),
                               ),
                             ),
                             const SizedBox(
                               height: 20,
                             ),
                             Expanded(
                               child: OutlinedButton(
                                   onPressed: (){},
                                   child: Text('Add Note'),
                               ),
                             ),

                           ],
                         ),

                       ],
                     ),
                   );
            });

          },
          label: Text('Add Note'),
      ),
      appBar: AppBar(

      ),
      body: Padding(
        padding: const    EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: Column(
          children: [
            allNotes.isNotEmpty ? ListView.builder(
                 itemCount: allNotes.length,
                itemBuilder: (context,index){
                   return ListTile(
                     leading: Text(allNotes[index][dbRef!.COLMN_NOTE_SNO.toString()]),
                     title: Text(allNotes[index][dbRef!.COLMN_NOTE_TITLE]),
                     subtitle: Text(allNotes[index][dbRef!.COLMN_NOTE_DESC])
                   );

                }
            ): const Center(
              child: Text('No Notes Yet!!'),
            ),


          ],
        ),
      ),
    );
  }
}
