class RegistrationData {
  // Common fields for both doctors and patients
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String dob; // Date of birth in 'dd/MM/yyyy' format
  final String password;

  // Doctor-specific fields (optional)
  final String? licenseNumber;
  final String? specialization;
  final String? workSetting;
  final String? street;
  final String? city;
  final String? state;
  final String? zip;
  final bool? hasClinic;
  final String? clinicName;
  final String? clinicAddress;
  final bool isVerified; // Default value is false

  // Patient-specific fields (optional)
  final String? aadharNo;
  final String? address;

  // Unique ID for both doctors and patients
  final String uniqueId;

  // Constructor for common fields
  RegistrationData({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.password,
    this.licenseNumber, // Optional for doctors
    this.specialization, // Optional for doctors
    this.workSetting, // Optional for doctors
    this.street, // Optional for doctors
    this.city, // Optional for doctors
    this.state, // Optional for doctors
    this.zip, // Optional for doctors
    this.hasClinic, // Optional for doctors
    this.clinicName, // Optional for doctors
    this.clinicAddress, // Optional for doctors
    this.aadharNo, // Optional for patients
    this.address, // Optional for patients
    this.isVerified = false, // Default value is false
    this.uniqueId = '', // Default value is empty
  });

  // Factory method for creating a Doctor registration object
  factory RegistrationData.forDoctor({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String dob,
    required String password,
    required String licenseNumber,
    required String specialization,
    required String workSetting,
    required String street,
    required String city,
    required String state,
    required String zip,
    required bool hasClinic,
    String? clinicName,
    String? clinicAddress,
    bool isVerified = false,
    String uniqueId = '',
  }) {
    return RegistrationData(
      name: name,
      email: email,
      phone: phone,
      gender: gender,
      dob: dob,
      password: password,
      licenseNumber: licenseNumber,
      specialization: specialization,
      workSetting: workSetting,
      street: street,
      city: city,
      state: state,
      zip: zip,
      hasClinic: hasClinic,
      clinicName: clinicName,
      clinicAddress: clinicAddress,
      isVerified: isVerified,
      uniqueId: uniqueId,
    );
  }

  // Factory method for creating a Patient registration object
  factory RegistrationData.forPatient({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String dob,
    required String password,
    required String aadharNo,
    required String address,
    String uniqueId = '',
  }) {
    return RegistrationData(
      name: name,
      email: email,
      phone: phone,
      gender: gender,
      dob: dob,
      password: password,
      aadharNo: aadharNo,
      address: address,
      uniqueId: uniqueId,
    );
  }
}


