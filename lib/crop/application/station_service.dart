import 'package:greentools/crop/domain/station.dart';
import 'package:greentools/crop/infrastructure/station_repository.dart';

class StationService {
  final StationRepository repository = StationRepository();

  Future<List<Station>> fetchAllStations() {
    return repository.getAllStations();
  }

  Future<Station> fetchStationById(int id) {
    return repository.getStationById(id);
  }

  Future<List<Station>> fetchStationsByUserId(int userId) {
    return repository.getStationsByUserId(userId);
  }

  Future<void> addStation(Station station) {
    return repository.createStation(station);
  }

  Future<void> modifyStation(int id, Station station) {
    return repository.updateStation(id, station);
  }

  Future<void> removeStation(int id) {
    return repository.deleteStation(id);
  }
}
