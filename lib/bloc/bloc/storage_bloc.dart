
import 'package:elanser_firebase/bloc/events/storage_events.dart';
import 'package:elanser_firebase/bloc/states/storage_states.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/fb_storage_controller.dart';

class StorageBloc extends Bloc<StorageEvents , StorageStates>{

  List<Reference> _reference = <Reference>[];

  final  FbStorageController _fbStorageController = FbStorageController();

  StorageBloc(super.initialState){
    on<UploadEvents>(_onUploadEvent);
    on<ReadEvents>(_onReadEvent);
    on<DeletedEvents>(_onDeleteEvent);
  }

  void _onUploadEvent(UploadEvents uploadEvents , Emitter emitter){
     _fbStorageController.upload(path: uploadEvents.filePath).listen((event) {
      if(event.state == TaskState.error){
        emit(ProcessState(false, 'Image upload field !' ?? '', Process.create));
      }else if(event.state == TaskState.success){
        emit(ProcessState(true, 'Image upload successfully !' ?? '', Process.create));
        _reference.add(event.ref);
        emit(ReadeState(_reference));
      }
    }).asFuture();
  }
  void _onReadEvent(ReadEvents uploadEvents , Emitter emitter)async{
    List<Reference> referance = await _fbStorageController.read();
    _reference = referance ;
    emit(ReadeState(_reference));
  }
  void _onDeleteEvent(DeletedEvents uploadEvents , Emitter emitter)async{
    bool deleted = await _fbStorageController.delete(path: uploadEvents.filePath);
    if(deleted){
      int index = _reference.indexWhere((element) => element.fullPath == uploadEvents.filePath);
      if(index != -1){
        _reference.removeAt(index);
        emit(ReadeState(_reference));
      }

    }
    emit(ProcessState(deleted, deleted ? 'Deleted successfully ' : 'Deleted field', Process.delete));
  }

}