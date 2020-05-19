import 'dart:async';

import 'package:meta/meta.dart';
import 'package:timetracker/app/home/models/job.dart';
import 'package:timetracker/services/firestore_service.dart';

import 'api_path.dart';

abstract class Database {
  Future<void> setJob(Job job);

  Stream<List<Job>> jobsStream();

  Future<void> deleteJob(Job job);
}

String documentIdFromCurrentDate()=>DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({ @required this.uid}) : assert(uid != null);
  final String uid;
  final  _service = FirestoreService.instance;

  @override
  Future<void> setJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

  @override
  Future<void> deleteJob(Job job) async=>   await _service.deleteData(
    path: APIPath.job(uid, job.id)
  );


  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data,documentId)=>Job.fromMap(data,documentId),
      );


}
