import 'package:collection/collection.dart';
import 'package:greentools/crop/domain/inventory.dart';
import 'package:greentools/crop/infrastructure/inventory_repository.dart';

class InventoryService {
  final InventoryRepository _inventoryRepository = InventoryRepository();

  // Método para obtener todos los inventarios
  Future<List<Inventory>> getAllInventories() async {
    try {
      return await _inventoryRepository.getInventories();
    } catch (e) {
      throw Exception("Error al obtener la lista de inventarios: $e");
    }
  }

  // Método para obtener un inventario por su ID
  Future<Inventory?> getInventoryById(int id) async {
    try {
      List<Inventory> inventories = await _inventoryRepository.getInventories();
      return inventories.firstWhereOrNull((inventory) => inventory.id == id);
    } catch (e) {
      throw Exception("Error al obtener el inventario: $e");
    }
  }

  // Método para buscar inventarios por nombre de estación
  Future<List<Inventory>> searchInventoriesByStationName(String stationName) async {
    try {
      List<Inventory> inventories = await _inventoryRepository.getInventories();
      return inventories
          .where((inventory) => inventory.stationName.toLowerCase().contains(stationName.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception("Error al buscar inventarios por nombre de estación: $e");
    }
  }

  // Método para buscar inventarios por id de usuario
  Future<List<Inventory>> getInventoriesByUserId(int userId) async {
    try {
      List<Inventory> inventories = await _inventoryRepository.getInventories();
      return inventories.where((inventory) => inventory.userId == userId).toList();
    } catch (e) {
      throw Exception("Error al obtener la lista de inventarios por userId: $e");
    }
  }

  // Método para obtener todos los inventarios del APIFake
  Future<List<Inventory>> getFakeInventories() async {
    return await _inventoryRepository.getFakeInventories();
  }
}
