import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/komisija.dart';
import 'package:emekteb_admin/providers/komisija_provider.dart';
import 'package:emekteb_admin/providers/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/admin.dart';
import '../models/korisnik.dart';
import '../models/searches/change_password_request.dart';
import '../models/searches/search_result.dart';
import '../providers/admin_provider.dart';

void main() {
  runApp(const Postavke());
}

class Postavke extends StatefulWidget {
  const Postavke({super.key});

  @override
  State<Postavke> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Postavke> {
  late PasswordProvider _passwordProvider;
  late KomisijaProvider _komisijaProvider;
  late AdminProvider _adminProvider;

  SearchResult<Komisija>? listaMualima;
  List<Komisija> filteredList = [];
  SearchResult<Admin>? listaAdmina;
  List<Admin> filteredListAdmin = [];
  int currentPage = 1; // Track the current page
  int numPages = 12; // Adjust the page size according to your backend configuration
  bool isLoading = false;
  int ukupnoMualima = 1;
  bool isSortAsc = false;
  bool _isVisible = false;
  bool _isCommissionBoxVisible = false;
  bool _isAdminBoxVisible = false;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();



  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _passwordProvider = context.read<PasswordProvider>();
    _komisijaProvider = context.read<KomisijaProvider>();
    _adminProvider = context.read<AdminProvider>();

  }


  void _toggleVisibility() {
    setState(() {
      _isCommissionBoxVisible = false;
      _isAdminBoxVisible = false;
      _isVisible = !_isVisible;
    });
  }

  void _toggleCommissionBoxVisibility() {
    setState(() {
      fetchDataKomisija();
      _isCommissionBoxVisible = !_isCommissionBoxVisible;
      _isVisible = false;
      _isAdminBoxVisible = false;
    });
  }

  void _toggleAdminBoxVisibility() {
    setState(() {
      fetchDataAdmin();
      _isAdminBoxVisible = !_isAdminBoxVisible;
      _isVisible = false;
      _isCommissionBoxVisible = false;
    });
  }

  Future<void> fetchDataKomisija({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaMualima = null;
        filteredList.clear();
      });

      var data = await _komisijaProvider.get(page: currentPage, pageSize: numPages, sort: isSortAsc);

      setState(() {
        if (listaMualima == null) {
          listaMualima = data;
          ukupnoMualima = data.count;
        } else {
          listaMualima!.result.addAll(data.result);
        }

        filteredList = listaMualima?.result ?? [];
        isLoading = false;
      });
    }
  }

  Future<void> fetchDataAdmin({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaAdmina = null;
        filteredList.clear();
      });

      var data = await _adminProvider.get(page: currentPage, pageSize: numPages, sort: isSortAsc);

      setState(() {
        if (listaAdmina == null) {
          listaAdmina = data;
          ukupnoMualima = data.count;
        } else {
          listaAdmina!.result.addAll(data.result);
        }

        filteredListAdmin = listaAdmina?.result ?? [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Postavke",
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buttons(),
            _boxPassword(),
            _boxAdmin(),
            _boxKomisija(),
          ],
        ),
      ),
    );
  }

  Widget _buttons() {
    String userRole = getCurrentUserRole();
    bool isKomisija = userRole == "Komisija";
    return Padding(
      padding: const EdgeInsets.only(
          left: 100.0, right: 100.0, top: 50.0, bottom: 50.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.cyan.shade700, // Border color
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.circular(1.0), // Rounded corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 30,
            ),
            ElevatedButton(
              onPressed: _toggleVisibility,
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                padding:
                    const EdgeInsets.all(16.0), // Increase padding if needed
                minimumSize:
                    const Size(200, 60), // Set a minimum size (width, height)
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(Icons.download),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Sigurnost",
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            if(!isKomisija)
            ElevatedButton(
              onPressed: () {
                _toggleAdminBoxVisibility();
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                padding:
                    const EdgeInsets.all(16.0), // Increase padding if needed
                minimumSize:
                    const Size(200, 60), // Set a minimum size (width, height)
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon(Icons.download),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Upravljanje adminima",
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            if(!isKomisija)
            ElevatedButton(
              onPressed: _toggleCommissionBoxVisibility,
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                padding:
                    const EdgeInsets.all(16.0), // Increase padding if needed
                minimumSize:
                    const Size(200, 60), // Set a minimum size (width, height)
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon(Icons.download),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Upravljanje komisijom",
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
  Widget _boxPassword() {
    return Visibility(
      visible: _isVisible,
      child: Container(
        width: 450,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Izmjena lozinke:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildTextField('Stara lozinka:', _oldPasswordController),
            const SizedBox(height: 10),
            _buildTextField('Nova lozinka:', _newPasswordController),
            const SizedBox(height: 10),
            _buildTextField('Potvrda lozinke:', _confirmPasswordController),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  if (_newPasswordController.text == _confirmPasswordController.text) {
                    try {
                      var request = ChangePasswordRequest(
                        userId: Korisnik.id, // Replace with the actual userId
                        oldPassword: _oldPasswordController.text,
                        newPassword: _newPasswordController.text,
                      );
                      await _passwordProvider.changePassword(request);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lozinka uspješno promijenjena')),
                      );
                      _oldPasswordController.clear();
                      _newPasswordController.clear();
                      _confirmPasswordController.clear();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Nije moguće promjeniti lozinku: $e')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Netačna potvrda lozinke')),

                    );
                    _newPasswordController.clear();
                    _confirmPasswordController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  padding: const EdgeInsets.only(
                      left: 18.0, right: 18.0, top: 16.0, bottom: 16.0),
                ),
                child: const Text('SPASI', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _boxKomisija() {
    return Visibility(
      visible: _isCommissionBoxVisible,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
         // width: 1200,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Komisija za takmičenje',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () => _showCreateForm(context, _komisijaProvider),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      padding: const EdgeInsets.only(
                          left: 18.0, top: 16.0, bottom: 16.0),
                    ),
                    child: const Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Član komisije",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _tabela(),
              ),

              const SizedBox(height: 10),
              // Add more rows or data as needed

            ],
          ),
        ),
      ),
    );
  }
  Widget _boxAdmin() {
    return Visibility(
      visible: _isAdminBoxVisible,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //width: 1200,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upravljanje adminima e-Mekteba',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () => _showCreateForm2(context, _komisijaProvider),
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      padding: const EdgeInsets.only(
                          left: 18.0, top: 16.0, bottom: 16.0),
                    ),
                    child: const Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Admin",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

              ),
              const SizedBox(height: 40),
              _tabelaAdmin(),
              const SizedBox(height: 10),
              // Add more rows or data as needed

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTextField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
              labelText: label,
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
  String getCurrentUserRole() {
    if (Korisnik.uloge.contains("Komisija")) {
      return "Komisija";
    } else {
      return "Admin";
    }
  }


  void _showCreateForm(BuildContext context, KomisijaProvider provider) {
    final formKey = GlobalKey<FormState>();
    String ime = '';
    String prezime = '';
    String username = '';
    String telefon = '';
    String mail = '';
    String spol = 'M';
    String status = 'Aktivan';
    DateTime datumRodjenja = DateTime.now();
    String imeRoditelja = '';
    String password = '';
    String passwordPotvrda = '';
    int? mektebId = 1;

    final TextEditingController datumRodjenjaController = TextEditingController();

    // Initializing the text fields with the current date values
    datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj člana komisije'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2, // Set the width to 80% of the screen width
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ime = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Prezime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite prezime';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        prezime = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Korisničko ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite korisničko ime';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        telefon = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Mail'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite mail';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        mail = value!;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Spol'),
                      value: spol,
                      items: ['M', 'Ž'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        spol = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite spol';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Status'),
                      value: status,
                      items: ['Aktivan', 'Neaktivan'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        status = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite status';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: datumRodjenjaController,
                      decoration: const InputDecoration(labelText: 'Datum rođenja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Datum rođenja';
                        }
                        return null;
                      },
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: datumRodjenja,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != datumRodjenja) {
                          setState(() {
                            datumRodjenja = picked;
                            datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];
                          });
                        }
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Ime roditelja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime jednog roditelja';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        imeRoditelja = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite password';
                        }
                        password = value; // Save password to compare later
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Potvrda passworda'),
                      obscureText: true, // Hide the password input
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Potvrdite password';
                        } else if (value != password) {
                          return 'Lozinke se ne podudaraju'; // Passwords do not match
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordPotvrda = value!;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Odustani'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Spremi'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  bool result = await provider.insert(
                    ime,
                    prezime,
                    username,
                    telefon,
                    mail,
                    spol,
                    status,
                    datumRodjenja,
                    imeRoditelja,
                    mektebId,
                    password,
                    passwordPotvrda,
                  );
                  fetchDataKomisija();
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Član komisije uspješno dodan')),
                    );
                    fetchDataKomisija();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri dodavanju člana komisije')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
  void _showCreateForm2(BuildContext context, KomisijaProvider provider) {
    final formKey = GlobalKey<FormState>();
    String ime = '';
    String prezime = '';
    String username = '';
    String telefon = '';
    String mail = '';
    String spol = 'M';
    String status = 'Aktivan';
    DateTime datumRodjenja = DateTime.now();
    String imeRoditelja = '';
    String password = '';
    String passwordPotvrda = '';
    int? mektebId = 1;

    final TextEditingController datumRodjenjaController = TextEditingController();

    // Initializing the text fields with the current date values
    datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj admina'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2, // Set the width to 80% of the screen width
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ime = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Prezime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite prezime';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        prezime = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Korisničko ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite korisničko ime';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        telefon = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Mail'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite mail';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        mail = value!;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Spol'),
                      value: spol,
                      items: ['M', 'Ž'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        spol = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite spol';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Status'),
                      value: status,
                      items: ['Aktivan', 'Neaktivan'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        status = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite status';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: datumRodjenjaController,
                      decoration: const InputDecoration(labelText: 'Datum rođenja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Datum rođenja';
                        }
                        return null;
                      },
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: datumRodjenja,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != datumRodjenja) {
                          setState(() {
                            datumRodjenja = picked;
                            datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];
                          });
                        }
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Ime roditelja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime jednog roditelja';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        imeRoditelja = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite password za admina';
                        }
                        password = value; // Save password to compare later
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Potvrda passworda'),
                      obscureText: true, // Hide the password input
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Potvrdite password';
                        } else if (value != password) {
                          return 'Lozinke se ne podudaraju'; // Passwords do not match
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordPotvrda = value!;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Odustani'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Spremi'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  bool result = await provider.insertAdmin(
                    ime,
                    prezime,
                    username,
                    telefon,
                    mail,
                    spol,
                    status,
                    datumRodjenja,
                    imeRoditelja,
                    mektebId,
                    password,
                    passwordPotvrda,
                  );
                  fetchDataAdmin();
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Admin uspješno dodan')),
                    );
                    fetchDataAdmin();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri dodavanju admina')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
  Widget _tabela(){
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : listaMualima == null
        ? const Center(child: Text('No data available'))
        : SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            dataTextStyle: const TextStyle(fontSize: 16),
            columns: const [
              DataColumn(
                label: Text('Ime'),
              ),
              DataColumn(label: Text('Prezime')),
              DataColumn(label: Text('Telefon')),
              DataColumn(label: Text('Izbriši')),
            ],
            rows: filteredList.map<DataRow>((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item.ime.toString())),
                  DataCell(Text(item.prezime.toString())),
                  DataCell(Text((item.telefon.toString())),),
                  DataCell(
                    IconButton(
                      color: Colors.cyan.shade700,
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        bool confirmed = await _showConfirmationDialog(context);
                        if (confirmed) {
                          try {
                            await _komisijaProvider.deleteKomisija(item.id);
                            setState(() {
                              filteredList.remove(item);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Uspješno izbrisano!')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Greška prilikom brisanja: $e')),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  Widget _tabelaAdmin(){
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : listaAdmina == null
        ? const Center(child: Text('No data available'))
        : SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            dataTextStyle: const TextStyle(fontSize: 16),
            columns: const [
              DataColumn(
                label: Text('Ime'),
              ),
              DataColumn(label: Text('Prezime')),
              DataColumn(label: Text('Telefon')),
              DataColumn(label: Text('Izbriši')),
            ],
            rows: filteredListAdmin.map<DataRow>((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item.ime.toString())),
                  DataCell(Text(item.prezime.toString())),
                  DataCell(Text((item.telefon.toString())),),
                  DataCell(
                    IconButton(
                      color: Colors.cyan.shade700,
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        bool confirmed = await _showConfirmationDialog(context);
                        if (confirmed) {
                          try {
                            await _komisijaProvider.deleteKomisija(item.id);
                            setState(() {
                              filteredListAdmin.remove(item);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Uspješno izbrisano!')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Greška prilikom brisanja: $e')),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return (await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Potvrda brisanja'),
          content: const Text('Jeste li sigurni da želite izbrisati ovog korisnika?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('POTVRDI', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    )) ?? false;
  }

}
