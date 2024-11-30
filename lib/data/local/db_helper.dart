import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  // constructor is being private
  DbHelper._();

  /// Db Helper class ka 1 hi object bana ga jo hum puri app ma use kar skta han isko singleton khta han

  static DbHelper getInstance(){
    return DbHelper._();
  }

  /// Create Table note
  final String TABLE_NOTE = "note";
  final String COLMN_NOTE_SNO =  "s_no";
  final String COLMN_NOTE_TITLE = "title";
  final String COLMN_NOTE_DESC = "desc";




  /// 2nd method without function to creating a instance
   // static final DbHelper  getInstance  = DbHelper._();

   // db open (path -> if exists than open else Create


   /// Now start work
    // create global variable
    Database? myDb;

    Future<Database> getDb() async{

      myDb ??= await openDb();
      return myDb!;

       // if(myDb!=null){
       //   return myDb!;
       // }
       // else{
       //  myDb = await openDb();
       //  return myDb!;
       // }



     }

     Future<Database> openDb() async{

      Directory appDir = await getApplicationDocumentsDirectory();

      /// join operation hame path package sa mil raha ha
      String dbPath = join(appDir.path ,"noteDB.db");
      
       return await openDatabase(dbPath, onCreate: (db,version){

        // create all your tables here ya pori line table create karti ha
         db.execute("create table  $TABLE_NOTE "
             "( $COLMN_NOTE_SNO integer primary key autoincrement, $COLMN_NOTE_TITLE  text, $COLMN_NOTE_DESC text) ");



      } ,version: 1);

     }

     // All Queries
      Future<bool>  addNote({required String title,required String desc})async {

        var db = await getDb();

       int rowsEffected = await db.insert(TABLE_NOTE, {
          COLMN_NOTE_TITLE: title,
          COLMN_NOTE_DESC: desc,
        });
       return rowsEffected>0;
      }

      // Get Query

     Future<List<Map<String, dynamic>>>  getAllNotes() async{

         var db = await getDb();
         List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE);
         return mData;

      }


}