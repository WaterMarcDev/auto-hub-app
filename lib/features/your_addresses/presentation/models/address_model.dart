class AddressModel {
  final String id;
  final String type; // 'home' | 'work' | 'other'
  final String label;
  final String streetAddress;
  final String city;
  final String state;
  final String zip;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.type,
    required this.label,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zip,
    required this.isDefault,
  });

  AddressModel copyWith({
    String? id,
    String? type,
    String? label,
    String? streetAddress,
    String? city,
    String? state,
    String? zip,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      type: type ?? this.type,
      label: label ?? this.label,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
