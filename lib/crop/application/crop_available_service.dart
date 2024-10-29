import '../domain/crop_available.dart';
import '../infrastructure/crop_available_repository.dart';

class CropAvailableService {
  final CropAvailableRepository _cropAvailableRepository;

  CropAvailableService(this._cropAvailableRepository);

  Future<List<CropAvailable>> getAvailablePlants() async {
    return await _cropAvailableRepository.getAvailableCrop();
  }
}