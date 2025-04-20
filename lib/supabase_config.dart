import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://uynjdfhvhuyvpfbihccb.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV5bmpkZmh2aHV5dnBmYmloY2NiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE2NzMyMTUsImV4cCI6MjA1NzI0OTIxNX0.2oAhyzf7TuWVm-fuiZVqxwkjozX0_vXQcer1M8Ey3FI',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
