

import 'package:dartz/dartz.dart';

import '../../core/error/error.dart';
import '../entity/person.dart';

abstract class IPersonRepository {
  Future<Either<Failure, List<Person>>> findPeople();
  Future<Either<Failure, Person>> findPerson(String document);
}