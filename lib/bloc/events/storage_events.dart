abstract class StorageEvents{}

class UploadEvents extends StorageEvents{
   String filePath ;

  UploadEvents(this.filePath);
}

class ReadEvents extends StorageEvents{}

class DeletedEvents extends StorageEvents{
  String filePath ;

 DeletedEvents(this.filePath);
}