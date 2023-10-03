import 'package:cached_network_image/cached_network_image.dart';
import 'package:elanser_firebase/bloc/bloc/storage_bloc.dart';
import 'package:elanser_firebase/bloc/events/storage_events.dart';
import 'package:elanser_firebase/bloc/states/storage_states.dart';
import 'package:elanser_firebase/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> with Helpers {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<StorageBloc>(context).add(ReadEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Colors.cyan,
        title: const Text(
          'Images',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/upload_image_screen');
            },
            icon: const Icon(Icons.cloud_upload),
          ),
        ],
        centerTitle: true,
      ),
      body: BlocConsumer<StorageBloc, StorageStates>(
        listenWhen: (previous, current) =>
            current is ProcessState && current.process == Process.delete,
        listener: (context, state) {
          state as ProcessState;
          showSnackBar(
              context: context, message: state.message, error: !state.status);
        },
        buildWhen: (previous, current) =>
            current is ReadeState || current is LoadingState,
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReadeState && state.reference.isNotEmpty) {
            return GridView.builder(
              padding: const EdgeInsetsDirectional.all(20),
              itemCount: state.reference.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  color: Colors.white,
                  clipBehavior:Clip.antiAlias ,
                  child: FutureBuilder<String>(
                      future: state.reference[index].getDownloadURL(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const Center(child: CircularProgressIndicator(),);
                        }else if(snapshot.hasData){
                          return Stack(
                            children: [
                              CachedNetworkImage(
                                width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              cacheKey: state.reference[index].fullPath,
                              imageUrl: snapshot.data!,
                              placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>const  Icon(Icons.error),
                            ),
                              Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                  child: Container(
                                    alignment: AlignmentDirectional.centerEnd,
                                    color: Colors.black38,
                                    height: 50,
                                    child: IconButton(
                                      onPressed: () => deleteImage(filePath: state.reference[index].fullPath),
                                      icon: Icon(Icons.delete, color: Colors.red.shade900,),
                                    ),
                                  ),
                              ),
                            ]
                          );
                        }
                        else{
                          return const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.warning,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'NO DATA',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 25,
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning,
                    size: 85,
                    color: Colors.grey,
                  ),
                  Text(
                    'NO DATA',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> deleteImage({required String filePath}) async {
    BlocProvider.of<StorageBloc>(context).add(DeletedEvents(filePath));
  }
}
