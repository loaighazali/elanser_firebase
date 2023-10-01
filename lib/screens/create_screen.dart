import 'package:elanser_firebase/controller/fb_firestore_controller.dart';
import 'package:elanser_firebase/helpers/helpers.dart';
import 'package:flutter/material.dart';

import '../model/note.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key, this.title = 'create', this.note })
      : super(key: key);

  final String title;

  final Note? note;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> with Helpers {

  late TextEditingController _titleEditingController;

  late TextEditingController _detailsEditingController;


  @override
  void initState() {
    // TODO: implement initState
    _titleEditingController = TextEditingController(text: widget.note?.title ?? '');
    _detailsEditingController = TextEditingController(text:  widget.note?.details ?? '');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleEditingController.dispose();
    _detailsEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding:
        const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 20),
        children: [
          const SizedBox(
            height: 50,
          ),
          TextField(
            controller: _titleEditingController,
            decoration: InputDecoration(
              hintText: 'title',
              prefixIcon: const Icon(Icons.title),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextField(
            controller: _detailsEditingController,
            decoration: InputDecoration(
              hintText: 'details',
              prefixIcon: const Icon(Icons.details),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),

          const SizedBox(height: 50,),

          ElevatedButton(
            onPressed: () async => await performProcess(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              'SAVE',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performProcess() async {
    if(checkData()){
      await process();
    }
  }

  bool checkData() {
    if (_titleEditingController.text.isNotEmpty &&
        _detailsEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter your data !', error: true);
    return false;
  }

  Future<void> process() async {
   bool status = await widget.title == 'create'
        ?await FbFireStoreController().create(note:note)
        :await FbFireStoreController().update(note:note);

   if(status){
     if(widget.note == null){
       clear();
       showSnackBar(context: context, message: 'Process success');
     }else{
     Navigator.pop(context);
     showSnackBar(context: context, message: 'Process success');
     }
   }else
   showSnackBar(context: context, message: 'Process field', error:  true);
  }

  Note get note {
    Note note = widget.note == null ? Note() : widget.note!;
    note.title = _titleEditingController.text;
    note.details = _detailsEditingController.text;
    return note;
  }

  void clear(){
    _titleEditingController.text = '';
    _detailsEditingController.text = '';
  }
}
