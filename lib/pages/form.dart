import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController lelakiController = TextEditingController();
  final TextEditingController perempuanController = TextEditingController();
  final TextEditingController ibuController = TextEditingController();
  final TextEditingController ayahController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tarikhController = TextEditingController();
  final TextEditingController waktuController = TextEditingController();
  final TextEditingController taglineController = TextEditingController();

  @override
  void dispose() {
    lelakiController.dispose();
    perempuanController.dispose();
    ibuController.dispose();
    ayahController.dispose();
    alamatController.dispose();
    tarikhController.dispose();
    waktuController.dispose();
    taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF5), // Wedding white
      appBar: AppBar(
        title: const Text(
          'Borang Kenduri',
          style: TextStyle(color: Color(0xFFB08D57)), // Gold title
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFFB08D57)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildFormField('Nama Pengantin Lelaki', lelakiController),
              buildFormField('Nama Pengantin Perempuan', perempuanController),
              buildFormField('Nama Ibu Pengantin', ibuController),
              buildFormField('Nama Ayah Pengantin', ayahController),
              buildFormField('Alamat Rumah', alamatController, maxLines: 3),
              buildDateField('Tarikh', tarikhController),
              buildTimeField('Waktu Berlangsung Kenduri', waktuController),
              buildFormField('Ayat Tagline', taglineController),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB08D57), // Gold
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Borang dihantar')),
                      );
                    }
                  },
                  child: const Text(
                    'Hantar Borang',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFormField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFB08D57)),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFB08D57), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE0CBAE)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Sila isi $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFB08D57)),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFFB08D57)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFB08D57), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE0CBAE)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            controller.text = "${picked.day}/${picked.month}/${picked.year}";
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Sila isi $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildTimeField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFB08D57)),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(Icons.access_time, color: Color(0xFFB08D57)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFB08D57), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE0CBAE)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onTap: () async {
          TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (picked != null) {
            controller.text = picked.format(context);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Sila isi $label';
          }
          return null;
        },
      ),
    );
  }
}
