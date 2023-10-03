
import 'package:firebase_storage/firebase_storage.dart';

enum Process{create , delete }

abstract class StorageStates {}

class LoadingState extends StorageStates{}

class ProcessState extends StorageStates{

  bool status;
  String message ;
  Process process;

  ProcessState(this.status, this.message, this.process);
}

class ReadeState extends StorageStates{
  List<Reference> reference ;

  ReadeState(this.reference);
}