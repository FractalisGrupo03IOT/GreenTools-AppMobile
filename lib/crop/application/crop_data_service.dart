import 'package:collection/collection.dart';
import 'package:greentools/crop/domain/crop_data.dart';
import 'package:greentools/crop/infrastructure/crop_data_repository.dart';

class CropDataService {
  final CropDataRepository repository = CropDataRepository();

  Future<void> addCropData(CropData cropData) {
    return repository.createCropData(cropData);
  }

  Future<List<CropData>> fetchLastMonthCropData(int plantId) {
    return repository.getCropDataLastMonthById(plantId);
  }

  Future<List<CropData>> fetchCropDataByPlantId(int plantId) {
    return repository.getCropDataByPlantId(plantId);
  }
}