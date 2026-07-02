import 'package:auto_hub_app/features/your_addresses/domain/entities/address.dart';
import 'package:auto_hub_app/features/your_addresses/domain/repositories/address_repository.dart';

class MockAddressRepository implements AddressRepository {
  final List<Address> _addresses = [
    const Address(
      id: '1',
      type: 'home',
      label: 'Home',
      streetAddress: '4521 Westheimer Rd',
      city: 'Houston',
      state: 'TX',
      zip: '77027',
      isDefault: true,
    ),
    const Address(
      id: '2',
      type: 'work',
      label: 'Work',
      streetAddress: '1200 McKinney St, Suite 450',
      city: 'Houston',
      state: 'TX',
      zip: '77010',
      isDefault: false,
    ),
  ];

  @override
  Future<List<Address>> getAddresses() async {
    return List.unmodifiable(_addresses);
  }

  @override
  Future<void> addAddress(Address address) async {
    // If it's the first address, make it default
    if (_addresses.isEmpty) {
      _addresses.add(address.copyWith(isDefault: true));
    } else {
      _addresses.add(address);
    }
  }

  @override
  Future<void> updateAddress(Address address) async {
    final index = _addresses.indexWhere((a) => a.id == address.id);
    if (index != -1) {
      _addresses[index] = address;
    } else {
      // In undo scenarios, we might need to add it back if not found.
      _addresses.add(address);
    }
  }

  @override
  Future<void> deleteAddress(String id) async {
    final index = _addresses.indexWhere((a) => a.id == id);
    if (index == -1) return;

    final deleted = _addresses[index];
    _addresses.removeAt(index);

    if (deleted.isDefault && _addresses.isNotEmpty) {
      _addresses[0] = _addresses[0].copyWith(isDefault: true);
    }
  }

  @override
  Future<void> setDefaultAddress(String id) async {
    for (var i = 0; i < _addresses.length; i++) {
      _addresses[i] = _addresses[i].copyWith(
        isDefault: _addresses[i].id == id,
      );
    }
  }
}
