import 'package:dio/dio.dart';

import '../../core/http/http_client.dart';
import '../../domain/entity/person.dart';

class PersonRemoteDS {
  final HttpClient httpClient;

  PersonRemoteDS({
    required this.httpClient,
  });

  Future<Response> findPeople() async {
    return httpClient.get('/person');
  }

  Future<Response> findPerson(int id) {
    return httpClient.get('/person/$id');
  }

  Future<Response> createPerson(Person p) async {
    return httpClient.post('/person', p.toJson());
  }

  Future<Response> updatePerson(String id, Person p) async {
    return httpClient.put('/person/$id', p.toJson());
  }

  Future<Response> deletePerson(String id) async {
    return httpClient.delete('/person/$id');
  }
}
