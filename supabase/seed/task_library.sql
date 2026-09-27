-- Starter task library (trilingual). Sprint 1 target is 40-50 tasks with
-- images and audio — this seed is the first batch to build the feature
-- against; extend it from the admin panel as content is produced.
-- audio_* / image_url are left null until real assets are uploaded to
-- Supabase Storage.

insert into task_library (category, name_en, name_si, name_ta) values
  ('cleaning', 'Sweep and mop the floors', 'බිම අතුගා පිස දැමීම', 'தரை பெருக்கி துடைத்தல்'),
  ('kitchen', 'Wash the dishes', 'පිඟන් සේදීම', 'பாத்திரம் கழுவுதல்'),
  ('kitchen', 'Kitchen deep clean', 'කුස්සිය හොඳින් පිරිසිදු කිරීම', 'சமையலறை ஆழ்ந்த சுத்தம்'),
  ('laundry', 'Wash the clothes', 'රෙදි සේදීම', 'துணி துவைத்தல்'),
  ('laundry', 'Iron the clothes', 'රෙදි ඉස්තිරික්ක කිරීම', 'துணி அயர்ன் செய்தல்'),
  ('cleaning', 'Clean the bathrooms', 'නාන කාමර පිරිසිදු කිරීම', 'குளியலறை சுத்தம்'),
  ('cleaning', 'Dust the furniture', 'ගෘහ භාණ්ඩ දූවිලි පිසදැමීම', 'மரச்சாமான் தூசி துடைத்தல்'),
  ('cooking', 'Cook lunch', 'දිවා ආහාරය පිසීම', 'மதிய உணவு சமைத்தல்'),
  ('cooking', 'Cook dinner', 'රාත්‍රී ආහාරය පිසීම', 'இரவு உணவு சமைத்தல்'),
  ('other', 'Water the garden', 'උද්‍යානයට වතුර දැමීම', 'தோட்டத்திற்கு நீர் ஊற்றுதல்'),
  ('other', 'Take out the rubbish', 'කසළ ඉවත් කිරීම', 'குப்பை அகற்றுதல்'),
  ('cleaning', 'Clean the windows', 'ජනෙල් පිරිසිදු කිරීම', 'ஜன்னல் சுத்தம்'),
  ('kitchen', 'Clean the fridge', 'ශීතකරණය පිරිසිදු කිරීම', 'குளிர்சாதனப்பெட்டி சுத்தம்'),
  ('cleaning', 'Change the bed linen', 'ඇඳ ඇතිරිලි මාරු කිරීම', 'படுக்கை விரிப்பு மாற்றுதல்');
