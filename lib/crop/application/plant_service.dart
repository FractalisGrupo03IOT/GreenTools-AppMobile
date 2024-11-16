import 'package:greentools/crop/domain/plant.dart';
import 'package:greentools/crop/infrastructure/plant_repository.dart';

class PlantService {
  final PlantRepository repository = PlantRepository();

  Future<List<Plant>> fetchAllPlants() {
    return repository.getAllPlants();
  }

  Future<Plant> fetchPlantById(int id) {
    return repository.getPlantById(id);
  }

  Future<List<Plant>> fetchPlantsByStationId(int stationId) {
    return repository.getPlantsByStationId(stationId);
  }

  Future<void> addPlant(Plant plant) {
    return repository.createPlant(plant);
  }

  Future<void> removePlantsByStationId(int stationId) {
    return repository.deletePlantByStationId(stationId);
  }
}
