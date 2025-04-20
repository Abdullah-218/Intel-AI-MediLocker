import 'package:intel/supabase_config.dart';
import 'package:intel/models/registration_data.dart';
import 'package:supabase/supabase.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:bcrypt/bcrypt.dart';

class SupabaseService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  // Generate a unique ID for doctors in the format DOC:xxxx-xxxx
  String generateDoctorUniqueId() {
    final random = Random();
    final part1 = random.nextInt(9999).toString().padLeft(4, '0');
    final part2 = random.nextInt(9999).toString().padLeft(4, '0');
    return 'DOC:$part1-$part2';
  }

  // Generate a unique ID for patients in the format PAT:xxxx-xxxx
  String generatePatientUniqueId() {
    final random = Random();
    final part1 = random.nextInt(9999).toString().padLeft(4, '0');
    final part2 = random.nextInt(9999).toString().padLeft(4, '0');
    return 'PAT:$part1-$part2';
  }

  // Method to register a doctor by inserting into the doctors table
  Future<void> registerDoctor(RegistrationData data) async {
    try {
      // Validate and format the date of birth
      DateTime parsedDob;
      try {
        parsedDob = DateFormat('dd/MM/yyyy').parse(data.dob);
      } catch (e) {
        throw Exception(
            'Invalid date format for DOB: ${data.dob}. Expected format: dd/MM/yyyy');
      }

      // Hash the password
      final hashedPassword = BCrypt.hashpw(data.password, BCrypt.gensalt());

      // Generate a unique ID for the doctor
      final uniqueId = generateDoctorUniqueId();

      // Insert the doctor's details into the doctors table
      await _supabase.from('doctors').insert({
        'unique_id': uniqueId,
        'name': data.name,
        'email': data.email,
        'phone': data.phone,
        'gender': data.gender,
        'dob': DateFormat('yyyy-MM-dd').format(parsedDob),
        'license_number': data.licenseNumber,
        'specialization': data.specialization,
        'work_setting': data.workSetting,
        'street': data.street,
        'city': data.city,
        'state': data.state,
        'zip': data.zip,
        'has_clinic': data.hasClinic,
        'clinic_name': (data.hasClinic == true) ? data.clinicName : null,
        'clinic_address': (data.hasClinic == true) ? data.clinicAddress : null,
        'password': hashedPassword, // Store the hashed password
        'is_verified': true, // Automatically mark as verified
      });

      print('Doctor registered successfully. Unique ID: $uniqueId');
    } catch (e) {
      print('Error during registration: $e');
      if (e is PostgrestException) {
        print('Supabase error details: ${e.message}, Code: ${e.code}');
      }
      throw Exception('Failed to register doctor: ${e.toString()}');
    }
  }

  // Method to authenticate a doctor by checking credentials
  Future<bool> authenticateDoctor(String email, String password) async {
    try {
      // Query the doctors table to find the user
      final response = await _supabase
          .from('doctors')
          .select('id, password')
          .eq('email', email)
          .limit(1);

      if (response.isEmpty) {
        return false; // User not found
      }

      final doctorData = response.first;
      final storedHashedPassword = doctorData['password'] as String;

      // Verify the password
      if (BCrypt.checkpw(password, storedHashedPassword)) {
        return true; // Authentication successful
      } else {
        return false; // Incorrect password
      }
    } catch (e) {
      print('Error during authentication: $e');
      return false;
    }
  }

  // Method to register a patient by inserting into the patients table
  Future<void> registerPatient(RegistrationData data) async {
    try {
      // Validate and format the date of birth
      DateTime parsedDob;
      try {
        parsedDob = DateFormat('dd/MM/yyyy').parse(data.dob);
      } catch (e) {
        throw Exception(
            'Invalid date format for DOB: ${data.dob}. Expected format: dd/MM/yyyy');
      }

      // Hash the password
      final hashedPassword = BCrypt.hashpw(data.password, BCrypt.gensalt());

      // Generate a unique ID for the patient
      final uniqueId = generatePatientUniqueId();

      // Insert the patient's details into the patients table
      await _supabase.from('patients').insert({
        'unique_id': uniqueId,
        'name': data.name,
        'email': data.email,
        'phone': data.phone,
        'aadhar_no': data.aadharNo,
        'address': data.address,
        'gender': data.gender,
        'dob': DateFormat('yyyy-MM-dd').format(parsedDob),
        'password': hashedPassword, // Store the hashed password
      });

      print('Patient registered successfully. Unique ID: $uniqueId');
    } catch (e) {
      print('Error during registration: $e');
      if (e is PostgrestException) {
        print('Supabase error details: ${e.message}, Code: ${e.code}');
      }
      throw Exception('Failed to register patient: ${e.toString()}');
    }
  }

  Future<bool> authenticatePatient(String email, String password) async {
    try {
      // Validate email format
      if (!_isValidEmail(email)) {
        return false;
      }

      // Query the patients table to find the user
      final response = await _supabase
          .from('patients')
          .select('id, password') // Removed is_active
          .eq('email', email.trim().toLowerCase())
          .limit(1)
          .single(); // Fetch a single record directly

      final storedHashedPassword = response['password'] as String;

      // Verify the password using BCrypt
      return BCrypt.checkpw(password, storedHashedPassword);
    } catch (e) {
      print('Error during patient authentication: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> fetchPatientByEmail(String email) async {
    try {
      final response = await _supabase
          .from('patients')
          .select('*')
          .eq('email', email.trim().toLowerCase())
          .limit(1)
          .single(); // Fetch a single record directly

      response.remove('password');

      return response;
    } catch (e) {
      print('Error fetching patient data: $e');
      return null;
    }
  }

  // Email validation helper method
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email.trim());
  }
}