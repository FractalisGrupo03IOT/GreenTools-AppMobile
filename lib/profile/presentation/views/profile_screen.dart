import 'package:flutter/material.dart';
import 'package:greentools/common/utils/local_storage_service.dart';
import 'package:greentools/crop/application/user_service.dart';
import 'package:greentools/common/widgets/navigation_appbar.dart';
import 'package:greentools/crop/domain/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LocalStorageService _localStorageService = LocalStorageService();
  final UserService _userService = UserService();
  User? _user;
  bool _isLoading = true;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final userJson = await _localStorageService.getUser();
      if (userJson != null) {
        final user = User.fromJson(userJson);
        setState(() {
          _user = user;
          _firstNameController.text = user.name.firstName;
          _lastNameController.text = user.name.lastName;
          _emailController.text = user.email.address;
          _streetController.text = user.address.street;
          _numberController.text = user.address.number;
          _cityController.text = user.address.city;
          _zipCodeController.text = user.address.zipCode;
          _countryController.text = user.address.country;
        });
      }
    } catch (e) {
      print("Error loading user: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUser() async {
    try {
      if (_user == null) return;

      final updatedUser = User(
        id: _user!.id,
        name: Name(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
        ),
        email: Email(address: _emailController.text),
        profileImage: _user!.profileImage,
        address: Address(
          street: _streetController.text,
          number: _numberController.text,
          city: _cityController.text,
          zipCode: _zipCodeController.text,
          country: _countryController.text,
        ),
      );

      await _userService.updateUser(updatedUser.id, updatedUser);

      // Guardar el usuario actualizado en el almacenamiento local
      await _localStorageService.saveUser(updatedUser.toJson());

      // Mostrar éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User updated successfully!"),
        ),
      );

      Navigator.pop(context); // Cerrar el modal emergente
      setState(() {
        _user = updatedUser;
      });
    } catch (e) {
      print("Error updating user: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error updating user: $e"),
        ),
      );
    }
  }

  void _showUpdateInfoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField("First Name", _firstNameController),
                  _buildTextField("Last Name", _lastNameController),
                  _buildTextField("Email", _emailController),
                  _buildTextField("Street", _streetController),
                  _buildTextField("Number", _numberController),
                  _buildTextField("City", _cityController),
                  _buildTextField("Zip Code", _zipCodeController),
                  _buildTextField("Country", _countryController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A785D),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF3A785D),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _user == null
          ? const Center(
        child: Text(
          "No user data available.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _user!.profileImage.isNotEmpty
                  ? NetworkImage(_user!.profileImage)
                  : null,
              backgroundColor: Colors.grey[300],
              child: _user!.profileImage.isEmpty
                  ? const Icon(Icons.person, size: 50, color: Colors.grey)
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                const Divider(),
                const Text(
                  'Name',
                  style: TextStyle(color: Color(0xFF000000), fontSize: 16),
                ),
                const Divider(),
                _buildInfoRow('First Name', _user!.name.firstName),
                _buildInfoRow('Last Name', _user!.name.lastName),
                const Divider(),
                _buildInfoRow('Email', _user!.email.address),
                const Divider(),
                const Text(
                  'Address',
                  style: TextStyle(color: Color(0xFF000000), fontSize: 16),
                ),
                const Divider(),
                _buildInfoRow('Street', _user!.address.street),
                _buildInfoRow('Number', _user!.address.number),
                _buildInfoRow('City', _user!.address.city),
                _buildInfoRow('Zip Code', _user!.address.zipCode),
                _buildInfoRow('Country', _user!.address.country),
                const Divider(),
                TextButton(
                  onPressed: () => _showUpdateInfoSheet(context),
                  child: const Text(
                    'Update Info',
                    style: TextStyle(color: Color(0xFF3A785D), fontSize: 16),
                  ),
                ),
                const Divider(),
                TextButton(
                  onPressed: () {
                    _localStorageService.clearAll();
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 3,
        onDestinationSelected: (index) {
          print("Selected index: $index");
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}



