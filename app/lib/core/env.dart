/// Supabase project credentials, supplied at build/run time — never hard-coded.
///
/// Run with:
///   flutter run --dart-define-from-file=env.json
///
/// Copy env.example.json to env.json (gitignored) and fill in your project's
/// URL and anon key from Supabase → Settings → API.
class Env {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
}
