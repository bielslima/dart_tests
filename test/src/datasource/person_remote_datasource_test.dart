import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../bin/src/core/http/http_client.dart';
import '../../../bin/src/data/datasource/person_remote_datasource.dart';
import '../../../bin/src/domain/entity/person.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;
  late PersonRemoteDS personRemoteDS;

  group('PersonDS Unit tests', () {
    setUpAll(() {
      httpClient = HttpClientMock();
      personRemoteDS = PersonRemoteDS(httpClient: httpClient);

      final List<Map<String, dynamic>> jsonDataResult = [
        {
          "createdAt": "2022-06-02T15:17:26.535Z",
          "name": "Christopher Streich",
          "document": 13,
          "id": "1"
        },
        {
          "createdAt": "2022-06-02T18:37:48.195Z",
          "name": "Constance Collier",
          "document": 48,
          "id": "2"
        }
      ];

      when(() => httpClient.get('/person')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: jsonDataResult,
        ),
      );

      when(() => httpClient.post('/person', any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 201,
        ),
      );

      when(() => httpClient.put('/person/1', any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(() => httpClient.delete('/person/1')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );
    });

    test('should return one or more elements', () async {
      final result = await personRemoteDS.findPeople();

      final resultData = result.data as List;

      expect(resultData.isNotEmpty, equals(true));
    });

    test('should create a element', () async {
      final person = Person(
        name: 'Gabriel Lima',
        document: 0123,
      );

      final result = await personRemoteDS.createPerson(person);

      expect(result.statusCode, equals(201));
    });

    test('should update a element', () async {
      final person = Person(
        name: 'Gabriel Lima Updated',
        document: 0123,
      );

      final result = await personRemoteDS.updatePerson("1", person);

      expect(result.statusCode, equals(200));
    });

    test('should delete a element', () async {
      final result = await personRemoteDS.deletePerson('1');

      expect(result.statusCode, equals(200));
    });
  });
  group('PersonDS Integration tests', () {
    List elements = [];

    setUpAll(() {
      httpClient = HttpClient();
      personRemoteDS = PersonRemoteDS(httpClient: httpClient);
    });

    test('should return one or more elements', () async {
      final result = await personRemoteDS.findPeople();

      final resultData = result.data as List;

      elements = resultData.map((e) => Person.fromJson(e)).toList();

      expect(resultData.isNotEmpty, equals(true));
    });

    test('should create a element', () async {
      final person = Person(
        name: 'Gabriel Lima',
        document: 0123,
      );

      final result = await personRemoteDS.createPerson(person);

      expect(result.statusCode, equals(201));
    });

    test('should update a element', () async {
      final person = Person(
        name: 'Gabriel Lima Updated',
        document: 0123,
      );

      final result =
          await personRemoteDS.updatePerson(elements.first.id, person);

      expect(result.statusCode, equals(200));
    });

    test('should delete a element', () async {
      final result = await personRemoteDS.deletePerson(elements.first.id);

      expect(result.statusCode, equals(200));
    });
  });
}
