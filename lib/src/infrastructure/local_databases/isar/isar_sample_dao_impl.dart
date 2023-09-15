import 'dart:io';

import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../domain/services/isar/daos/isar_sample_dao.dart';
import '../../../domain/services/isar/dtos/sample_dto.dart';

class IsarSampleDAOImpl implements IsarSampleDAO {
  late final Isar _isar;

  IsarSampleDAOImpl() {
    _init();
  }

  Future<void> _init() async {
    Directory dir;
    if (GetPlatform.isAndroid) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = await getApplicationSupportDirectory();
    }
    _isar = Isar.openSync(
      [IsarSampleDTOSchema],
      directory: dir.path,
      name: IsarSampleDTO.nameSchema,
    );
  }

  @override
  Future<void> insertSample(IsarSampleDTO dto) async {
    await _isar.writeTxn(() async {
      await _isar.isarSampleDTOs.put(dto);
    });
  }
}
