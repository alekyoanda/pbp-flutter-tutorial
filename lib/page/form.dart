import 'package:tess/main.dart';
import 'package:flutter/material.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _namaLengkap = "";
  bool jenjangSarjana = false;
  bool jenjangDiploma = false;
  bool jenjangMagister = false;
  bool jenjangDoktor = false;
  List<String> listJenjang = ['Sarjana', 'Diploma', 'Magister', 'Doktor'];
  int indexJenjang = 0;
  double umur = 0;
  String kelasPBP = 'A';
  List<String> listKelasPBP = ['A', 'B', 'C', 'D', 'E', 'F', 'KI'];
  bool _nilaiSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Form'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    // Menggunakan padding sebesar 8 pixels
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Contoh: Pak Dengklek",
                        labelText: "Nama Lengkap",
                        // Menambahkan icon agar lebih intuitif
                        icon: const Icon(Icons.people),
                        // Menambahkan circular border agar lebih rapi
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Menambahkan behavior saat nama diketik
                      onChanged: (String? value) {
                        setState(() {
                          _namaLengkap = value!;
                        });
                      },
                      // Menambahkan behavior saat data disimpan
                      onSaved: (String? value) {
                        setState(() {
                          _namaLengkap = value!;
                        });
                      },
                      // Validator sebagai validasi form
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama lengkap tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ListTile(
                          leading: Icon(Icons.school),
                          title: Text("Jenjang"),
                        ),
                        CheckboxListTile(
                          title: const Text('Sarjana'),
                          value: jenjangSarjana,
                          onChanged: (bool? value) {
                            setState(() {
                              jenjangSarjana = value!;
                              indexJenjang = 0;
                              if (value) {
                                jenjangMagister =
                                    jenjangDiploma = jenjangDoktor = false;
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text('Diploma'),
                          value: jenjangDiploma,
                          onChanged: (bool? value) {
                            setState(() {
                              jenjangDiploma = value!;
                              indexJenjang = 1;
                              if (value) {
                                jenjangMagister =
                                    jenjangSarjana = jenjangDoktor = false;
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text('Magister'),
                          value: jenjangMagister,
                          onChanged: (bool? value) {
                            setState(() {
                              jenjangMagister = value!;
                              indexJenjang = 2;
                              if (value) {
                                jenjangDiploma =
                                    jenjangSarjana = jenjangDoktor = false;
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text('Doktor'),
                          value: jenjangDoktor,
                          onChanged: (bool? value) {
                            setState(() {
                              jenjangDoktor = value!;
                              indexJenjang = 3;
                              if (value) {
                                jenjangMagister =
                                    jenjangSarjana = jenjangDiploma = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.co_present),
                    title: Row(
                      children: [
                        Text('Umur: ${umur.round()}'),
                      ],
                    ),
                    subtitle: Slider(
                      value: umur,
                      max: 100,
                      divisions: 100,
                      label: umur.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          umur = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.class_),
                    title: const Text(
                      'Kelas PBP',
                    ),
                    trailing: DropdownButton(
                      value: kelasPBP,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: listKelasPBP.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          kelasPBP = newValue!;
                        });
                      },
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Practice Mode'),
                    value: _nilaiSwitch,
                    onChanged: (bool value) {
                      setState(() {
                        _nilaiSwitch = value;
                      });
                    },
                    secondary: const Icon(Icons.run_circle_outlined),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 15,
                              child: Container(
                                child: ListView(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Center(
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Informasi Data',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          Text('Nama Lengkap: $_namaLengkap'),
                                          Text(
                                              'Jenjang: ${listJenjang.elementAt(indexJenjang)}'),
                                          Text('Umur: ${umur.round()}'),
                                          Text('Kelas PBP: $kelasPBP'),
                                          Text('Practice Mode: $_nilaiSwitch')
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    // TODO: Munculkan informasi yang didapat dari form
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Kembali'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
