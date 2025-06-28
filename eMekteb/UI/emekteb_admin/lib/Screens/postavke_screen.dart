import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/komisija.dart';
import 'package:emekteb_admin/models/medzlis.dart';
import 'package:emekteb_admin/models/superadmin.dart';
import 'package:emekteb_admin/providers/komisija_provider.dart';
import 'package:emekteb_admin/providers/medzlis_provider.dart';
import 'package:emekteb_admin/providers/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/admin.dart';
import '../models/korisnik.dart';
import '../models/mail_object.dart';
import '../models/searches/change_password_request.dart';
import '../models/searches/search_result.dart';
import '../providers/admin_provider.dart';
import '../providers/mualim_provider.dart';
import 'package:collection/collection.dart';

import '../providers/superadmin_provider.dart'; // Add this at the top for searching list

void main() {
  runApp(const Postavke());
}

class Postavke extends StatefulWidget {
  const Postavke({super.key});

  @override
  State<Postavke> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Postavke> {
  var medzlis = Korisnik.medzlisId;
  var muftijstvoIde = Korisnik.muftijstvoId;

  late PasswordProvider _passwordProvider;
  late KomisijaProvider _komisijaProvider;
  late AdminProvider _adminProvider;
  late SuperAdminProvider _superAdminProvider;
  late MualimProvider _mualimProvider;
  late MedzlisProvider _medzlisProvider;

  SearchResult<Komisija>? listaMualima;
  List<Komisija> filteredList = [];
  SearchResult<Admin>? listaAdmina;
  List<Admin> filteredListAdmin = [];
  SearchResult<SuperAdmin>? listaSuperAdmina;
  List<SuperAdmin> filteredListSuperAdmins = [];
  int currentPage = 1; // Track the current page
  int numPages = 12; // Adjust the page size according to your backend configuration
  bool isLoading = false;
  bool isLoading2 = false;
  int ukupnoMualima = 1;
  bool isSortAsc = false;
  bool _isVisible = false;
  bool _isCommissionBoxVisible = false;
  bool _isSuperAdminsBoxVisible = false;
  bool _isAdminBoxVisible = false;
  SearchResult<Medzlis>? listaMedzlisa;
  int ukupnoMedzlisa = 1;
  List<Medzlis> filteredList2 = [];
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _passwordProvider = context.read<PasswordProvider>();
    _komisijaProvider = context.read<KomisijaProvider>();
    _adminProvider = context.read<AdminProvider>();
    _superAdminProvider = context.read<SuperAdminProvider>();
    _mualimProvider = context.read<MualimProvider>();
    _medzlisProvider = context.read<MedzlisProvider>();
    if(muftijstvoIde!=null) fetchDataMedzlisi();

  }
  
  void _toggleVisibility() {
    setState(() {
      _isCommissionBoxVisible = false;
      _isSuperAdminsBoxVisible = false;
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
      _isSuperAdminsBoxVisible = false;

    });
  }
  void _toggleSuperAdminsBoxVisibility() {
    setState(() {
      fetchDataSuperAdmin();
      _isSuperAdminsBoxVisible = !_isSuperAdminsBoxVisible;
      _isVisible = false;
      _isAdminBoxVisible = false;
      _isCommissionBoxVisible = false;

    });
  }
  void _toggleAdminBoxVisibility() {
    setState(() {
      String userRole = getCurrentUserRole();
      bool isSuperAdmin = userRole == "SuperAdmin";
      bool admin = userRole == "Admin";
      if(isSuperAdmin) {
        fetchDataAdminForMuftijstvo();
      } else if (admin) {
        fetchDataAdmin();
      }

      _isAdminBoxVisible = !_isAdminBoxVisible;
      _isVisible = false;
      _isCommissionBoxVisible = false;
      _isSuperAdminsBoxVisible = false;
      //print(medzlis);
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

      var data = await _komisijaProvider.get(page: currentPage, pageSize: numPages, sort: isSortAsc, medzlisId: medzlis);

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

      var data = await _adminProvider.get(page: currentPage, pageSize: numPages, sort: isSortAsc, medzlisId: medzlis);

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

  Future<void> fetchDataAdminForMuftijstvo({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaAdmina = null;
        filteredList.clear();
      });

      var data = await _adminProvider.getForMuftijstvo(page: currentPage, pageSize: numPages, sort: isSortAsc, muftijstvoId: muftijstvoIde);

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

  Future<void> fetchDataSuperAdmin({String? filter}) async {
    if (!isLoading2) {
      setState(() {
        isLoading2 = true;
        // Clear existing data when the filter changes
        listaSuperAdmina = null;
        filteredListSuperAdmins.clear();
      });

      var data = await _superAdminProvider.getForMuftijstvo(page: currentPage, pageSize: numPages, sort: isSortAsc, muftijstvoId: muftijstvoIde);

      setState(() {
        if (listaSuperAdmina == null) {
          listaSuperAdmina = data;
          ukupnoMualima = data.count;
        } else {
          listaSuperAdmina!.result.addAll(data.result);
        }

        filteredListSuperAdmins = listaSuperAdmina?.result ?? [];
        isLoading2 = false;
      });
    }
  }

  Future<void> fetchDataMedzlisi({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaMedzlisa = null;
        filteredList.clear();
      });

      var data = await _medzlisProvider.getForMuftijstvo(muftijstvoId: muftijstvoIde);

      setState(() {
        if (listaMedzlisa == null) {
          listaMedzlisa = data;
          ukupnoMedzlisa = data.count;
        } else {
          listaMedzlisa!.result.addAll(data.result);
        }

        filteredList2 = listaMedzlisa?.result ?? [];
        isLoading = false;
      });
    }
  }

  String getMektebNaziv(int? medzlisId) {
    if (medzlisId == null) return 'N/A';
    var medzlis = listaMedzlisa?.result.firstWhereOrNull((m) => m.id == medzlisId);
    return medzlis?.naziv ?? 'N/A';
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
            _boxSuperAdmini()
          ],
        ),
      ),
    );
  }

  Widget _buttons() {
    String userRole = getCurrentUserRole();
    bool isKomisija = userRole == "Komisija";
    bool isSuperAdmin = userRole == "SuperAdmin";
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
            if(!isKomisija && !isSuperAdmin)
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
            if(isSuperAdmin)
            ElevatedButton(
              onPressed: _toggleSuperAdminsBoxVisibility,
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
                    "Upravljanje muftijstvom",
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
                  // Check if any field is empty
                  if (_oldPasswordController.text.isEmpty ||
                      _newPasswordController.text.isEmpty ||
                      _confirmPasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sva polja moraju biti popunjena!')),
                    );
                    return;
                  }

                  // Check if the new password has at least 4 characters
                  if (_newPasswordController.text.length < 4) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nova lozinka mora imati najmanje 4 karaktera!')),
                    );
                    _newPasswordController.clear();
                    _confirmPasswordController.clear();
                    return;
                  }

                  // Check if the new password matches the confirmation
                  if (_newPasswordController.text != _confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Netačna potvrda lozinke!')),
                    );
                    _newPasswordController.clear();
                    _confirmPasswordController.clear();
                    return;
                  }

                  // Proceed with the password change request
                  try {
                    var request = ChangePasswordRequest(
                      userId: Korisnik.id, // Replace with the actual userId
                      oldPassword: _oldPasswordController.text,
                      newPassword: _newPasswordController.text,
                    );
                    await _passwordProvider.changePassword(request);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lozinka uspješno promijenjena!')),
                    );
                    _oldPasswordController.clear();
                    _newPasswordController.clear();
                    _confirmPasswordController.clear();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  padding: const EdgeInsets.only(
                      left: 18.0, right: 18.0, top: 16.0, bottom: 16.0),
                ),
                child: const Text(
                  'SPASI',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
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
                child: _tabelaKomisija(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _boxSuperAdmini() {
    return Visibility(
      visible: _isSuperAdminsBoxVisible,
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
                'Admini za nivo muftijstva ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () => _showCreateForm3(context, _superAdminProvider),
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
                          "Super admin",
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
                child: _tabelaSuperAdmin(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _boxAdmin() {
    String userRole = getCurrentUserRole();
    bool isSuperAdmin = userRole == "SuperAdmin";
    bool isAdmin = userRole == "Admin";
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
                'Admini za nivo medžlisa',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isSuperAdmin) {
                        _showCreateFormSuperAdminDodajeAdmina(context, _komisijaProvider);
                      } else if (isAdmin) {
                        _showCreateForm2(context, _komisijaProvider);
                      }
                    },
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
    }
    else if (Korisnik.uloge.contains("Admin")){
      return "Admin";
    }
    else
      return "SuperAdmin";
  }


  void _showCreateForm(BuildContext context, KomisijaProvider provider) {
    final formKey = GlobalKey<FormState>();
    String ime = '';
    String prezime = '';
    String username = '';
    String telefon = '';
    String mail = '';
    String spol = 'M';
    //String status = 'Aktivan';
    DateTime datumRodjenja = DateTime.now();
    String imeRoditelja = '';
    String password = '';
    String passwordPotvrda = '';
    int? mektebId = 1;
    int? medzlisId = medzlis;
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
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        } else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                          return 'Neispravan format!';
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
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Neispravan format maila!';
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
                   //DropdownButtonFormField<String>(
                   //  decoration: const InputDecoration(labelText: 'Status'),
                   //  value: status,
                   //  items: ['Aktivan', 'Neaktivan'].map((String value) {
                   //    return DropdownMenuItem<String>(
                   //      value: value,
                   //      child: Text(value),
                   //    );
                   //  }).toList(),
                   //  onChanged: (newValue) {
                   //    status = newValue!;
                   //  },
                   //  validator: (value) {
                   //    if (value == null || value.isEmpty) {
                   //      return 'Unesite status';
                   //    }
                   //    return null;
                   //  },
                   //),
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
                          firstDate: DateTime(1900),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite password';
                        }
                        password = value;
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Potvrda passworda'),
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
                    datumRodjenja,
                    imeRoditelja,
                    mektebId,
                    password,
                    passwordPotvrda,
                    medzlisId!
                  );
                  fetchDataKomisija();
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Član komisije uspješno dodan')),
                    );
                    fetchDataKomisija();
                    Navigator.of(context).pop();

                    // Construct the mail object
                    var mailObject = MailObject(
                      mail,  // mailAdresa
                      "Takmicenje",  // subject
                      "Esselamu alejkum, Postavljeni ste za člana komisije na ovogodišnjem takmičenju, pristupne podatke ćete dobiti na dan takmičenja. Hvala!",  // poruka
                    );

                    // Send the email
                    await provider.sendMail(mailObject);
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
    //String status = 'Aktivan';
    DateTime datumRodjenja = DateTime.now();
    String imeRoditelja = '';
    String password = '';
    String passwordPotvrda = '';
    int? mektebId = 1;
    int? medzlisId = medzlis;
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
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        } else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                          return 'Neispravan format!';
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
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Neispravan format maila!';
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
                   //DropdownButtonFormField<String>(
                   //  decoration: const InputDecoration(labelText: 'Status'),
                   //  value: status,
                   //  items: ['Aktivan', 'Neaktivan'].map((String value) {
                   //    return DropdownMenuItem<String>(
                   //      value: value,
                   //      child: Text(value),
                   //    );
                   //  }).toList(),
                   //  onChanged: (newValue) {
                   //    status = newValue!;
                   //  },
                   //  validator: (value) {
                   //    if (value == null || value.isEmpty) {
                   //      return 'Unesite status';
                   //    }
                   //    return null;
                   //  },
                   //),
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
                          firstDate: DateTime(1900),
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
                    datumRodjenja,
                    imeRoditelja,
                    mektebId,
                    password,
                    passwordPotvrda,
                    medzlisId!
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
  void _showCreateForm3(BuildContext context, SuperAdminProvider provider) {
    final formKey = GlobalKey<FormState>();
    String ime = '';
    String prezime = '';
    String username = '';
    String telefon = '';
    String mail = '';
    String spol = 'M';
    //String status = 'Aktivan';
    DateTime datumRodjenja = DateTime.now();
    String imeRoditelja = '';
    String password = '';
    String passwordPotvrda = '';
    int? mektebId = 1;
    int? muftijstvoId = muftijstvoIde;
    final TextEditingController datumRodjenjaController = TextEditingController();

    // Initializing the text fields with the current date values
    datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj super admina'),
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
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        } else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                          return 'Neispravan format!';
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
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Neispravan format maila!';
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
                    //DropdownButtonFormField<String>(
                    //  decoration: const InputDecoration(labelText: 'Status'),
                    //  value: status,
                    //  items: ['Aktivan', 'Neaktivan'].map((String value) {
                    //    return DropdownMenuItem<String>(
                    //      value: value,
                    //      child: Text(value),
                    //    );
                    //  }).toList(),
                    //  onChanged: (newValue) {
                    //    status = newValue!;
                    //  },
                    //  validator: (value) {
                    //    if (value == null || value.isEmpty) {
                    //      return 'Unesite status';
                    //    }
                    //    return null;
                    //  },
                    //),
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
                          firstDate: DateTime(1900),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite password';
                        }
                        password = value;
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Potvrda passworda'),
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
                      datumRodjenja,
                      imeRoditelja,
                      mektebId,
                      password,
                      passwordPotvrda,
                      muftijstvoId!
                  );
                  fetchDataKomisija();
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Super admin uspješno dodan!')),
                    );
                    Navigator.of(context).pop();
                    fetchDataSuperAdmin();

                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri dodavanju!')),
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
  void _showCreateFormSuperAdminDodajeAdmina(BuildContext context, KomisijaProvider provider) {
    final formKey = GlobalKey<FormState>();
    String ime = '';
    String prezime = '';
    String username = '';
    String telefon = '';
    String mail = '';
    String spol = 'M';
    DateTime datumRodjenja = DateTime.now();
    String imeRoditelja = '';
    String password = '';
    String passwordPotvrda = '';
    int? mektebId = 1;
    int? medzlisId;

    bool isLoading = false;
    final TextEditingController datumRodjenjaController = TextEditingController();

    datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj admina za medžlis'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Ime'),
                      validator: (value) => value == null || value.isEmpty ? 'Unesite ime' : null,
                      onSaved: (value) => ime = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Prezime'),
                      validator: (value) => value == null || value.isEmpty ? 'Unesite prezime' : null,
                      onSaved: (value) => prezime = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Korisničko ime'),
                      validator: (value) => value == null || value.isEmpty ? 'Unesite korisničko ime' : null,
                      onSaved: (value) => username = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        } else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                          return 'Neispravan format!';
                        }
                        return null;
                      },
                      onSaved: (value) => telefon = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Mail'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite mail';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Neispravan format maila!';
                        }
                        return null;
                      },
                      onSaved: (value) => mail = value!,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Medžlis',
                      ),
                      hint: const Text("Odaberite medžlis"),
                      value: medzlisId?.toString(),
                      onChanged: (newValue) {
                        setState(() {
                          medzlisId = int.tryParse(newValue!);
                        });
                      },
                      items: filteredList2.map<DropdownMenuItem<String>>((medzlis) {
                        return DropdownMenuItem<String>(
                          value: medzlis.id.toString(),
                          child: Text(medzlis.naziv.toString()),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Odaberite medžlis';
                        }
                        return null;
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
                      onChanged: (newValue) => spol = newValue!,
                    ),
                    TextFormField(
                      controller: datumRodjenjaController,
                      decoration: const InputDecoration(labelText: 'Datum rođenja'),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: datumRodjenja,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != datumRodjenja) {
                          datumRodjenja = picked;
                          datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite password';
                        }
                        password = value;
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Potvrda passworda'),
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
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Spremi'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  bool result = await provider.insertAdmin(
                      ime, prezime, username, telefon, mail, spol, datumRodjenja, imeRoditelja, mektebId, password, passwordPotvrda, medzlisId!);
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Admin uspješno dodan')));
                    fetchDataAdminForMuftijstvo();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Greška pri dodavanju admina')));
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }


  Widget _tabelaKomisija(){
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
              DataColumn(label: Text('Korisničko ime')),
              DataColumn(label: Text('Telefon')),
              DataColumn(label: Text('Mail')),
              DataColumn(label: Text('Uredi')),
              DataColumn(label: Text('Izbriši')),
            ],
            rows: filteredList.map<DataRow>((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item.ime.toString())),
                  DataCell(Text(item.prezime.toString())),
                  DataCell(Text(item.username.toString())),
                  DataCell(Text((item.telefon.toString())),),
                  DataCell(Text((item.mail.toString())),),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.cyan.shade700,),
                      onPressed: () async {
                        _showUpdateFormKomisija(context, _mualimProvider, item.id, item);
                      },
                    ),
                  ),
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
  Widget _tabelaSuperAdmin(){
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : listaSuperAdmina == null
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
              DataColumn(label: Text('Korisničko ime')),
              DataColumn(label: Text('Telefon')),
              DataColumn(label: Text('Mail')),
              DataColumn(label: Text('Uredi')),
              DataColumn(label: Text('Izbriši')),
            ],
            rows: filteredListSuperAdmins.map<DataRow>((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item.ime.toString())),
                  DataCell(Text(item.prezime.toString())),
                  DataCell(Text(item.username.toString())),
                  DataCell(Text((item.telefon.toString())),),
                  DataCell(Text((item.mail.toString())),),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.cyan.shade700,),
                      onPressed: () async {
                        _showUpdateFormSuperAdmin(context, _superAdminProvider, item.id, item);
                      },
                    ),
                  ),
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
                              filteredListSuperAdmins.remove(item);
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
    String userRole = getCurrentUserRole();
    bool isSuperAdmin = userRole == "SuperAdmin";
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
            columns: [
              const DataColumn(
                label: Text('Ime'),
              ),
              const DataColumn(label: Text('Prezime')),
              const DataColumn(label: Text('Korisničko ime')),
              const DataColumn(label: Text('Telefon')),
              const DataColumn(label: Text('Mail')),
              if(isSuperAdmin)
                const DataColumn(label: Text('Medžlis')),
              const DataColumn(label: Text('Uredi')),
              const DataColumn(label: Text('Izbriši')),
            ],
            rows: filteredListAdmin.map<DataRow>((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item.ime.toString())),
                  DataCell(Text(item.prezime.toString())),
                  DataCell(Text(item.username.toString())),
                  DataCell(Text((item.telefon.toString())),),
                  DataCell(Text((item.mail.toString())),),
                  if(isSuperAdmin)
                    DataCell(Text(getMektebNaziv(item.medzlisId?.toInt() ?? 0))),

                  DataCell(
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.cyan.shade700,),
                      onPressed: () async {
                        _showUpdateFormAdmin(context, _mualimProvider, item.id, item);
                      },
                    ),
                  ),
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
              child: const Text('Odustani'),
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

  void _showUpdateFormAdmin(BuildContext context, MualimProvider provider, int? userId, Admin userData) {
    final formKey = GlobalKey<FormState>();
    String? ime = userData.ime;
    String? prezime = userData.prezime;
    String? username = userData.username;
    String? telefon = userData.telefon;
    String? mail = userData.mail;
    String? spol = userData.spol;
    //String? status = userData.status;
    DateTime? datumRodjenja = userData.datumRodjenja;
    String? imeRoditelja = userData.imeRoditelja;
    int? mektebId = userData.mektebId;

    final TextEditingController datumRodjenjaController = TextEditingController();
    datumRodjenjaController.text = datumRodjenja!.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uredi podatke za admina'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: ime,
                      decoration: const InputDecoration(labelText: 'Ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ime je obavezno!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ime = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: prezime,
                      decoration: const InputDecoration(labelText: 'Prezime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Prezime je obavezno!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        prezime = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: username,
                      decoration: const InputDecoration(labelText: 'Korisničko ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite korisničko ime za mualima!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: telefon,
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        } else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                          return 'Neispravan format!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        telefon = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: mail,
                      decoration: const InputDecoration(labelText: 'Mail'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite mail mualima';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Neispravan format maila!';
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
                          return 'Unesite spol!';
                        }
                        return null;
                      },
                    ),
                    //DropdownButtonFormField<String>(
                    //  decoration: const InputDecoration(labelText: 'Status'),
                    //  value: status,
                    //  items: ['Aktivan', 'Neaktivan'].map((String value) {
                    //    return DropdownMenuItem<String>(
                    //      value: value,
                    //      child: Text(value),
                    //    );
                    //  }).toList(),
                    //  onChanged: (newValue) {
                    //    status = newValue!;
                    //  },
                    //  validator: (value) {
                    //    if (value == null || value.isEmpty) {
                    //      return 'Unesite status!';
                    //    }
                    //    return null;
                    //  },
                    //),
                    TextFormField(
                      controller: datumRodjenjaController,
                      decoration: const InputDecoration(labelText: 'Datum rođenja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite datum rođenja!';
                        }
                        return null;
                      },
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: datumRodjenja,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != datumRodjenja) {
                          datumRodjenja = picked;
                          datumRodjenjaController.text = datumRodjenja!.toLocal().toString().split(' ')[0];
                        }
                      },
                    ),
                    TextFormField(
                      initialValue: imeRoditelja,
                      decoration: const InputDecoration(labelText: 'Ime roditelja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime jednog roditelja!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        imeRoditelja = value!;
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
                  bool result = await provider.update(
                    userId,
                    ime!,
                    prezime!,
                    username!,
                    telefon!,
                    mail!,
                    spol!,
                    datumRodjenja!,
                    imeRoditelja!,
                    mektebId,
                  );
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Admin uspješno ažuriran')),
                    );
                    fetchDataAdmin();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri ažuriranju admina')),
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
  void _showUpdateFormKomisija(BuildContext context, MualimProvider provider, int? userId, Komisija userData) {
    final formKey = GlobalKey<FormState>();
    String? ime = userData.ime;
    String? prezime = userData.prezime;
    String? username = userData.username;
    String? telefon = userData.telefon;
    String? mail = userData.mail;
    String? spol = userData.spol;
   // String? status = userData.status;
    DateTime? datumRodjenja = userData.datumRodjenja;
    String? imeRoditelja = userData.imeRoditelja;
    int? mektebId = userData.mektebId;

    final TextEditingController datumRodjenjaController = TextEditingController();
    datumRodjenjaController.text = datumRodjenja!.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uredi podatke za komisiju'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: ime,
                      decoration: const InputDecoration(labelText: 'Ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ime je obavezno!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ime = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: prezime,
                      decoration: const InputDecoration(labelText: 'Prezime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Prezime je obavezno!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        prezime = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: username,
                      decoration: const InputDecoration(labelText: 'Korisničko ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite korisničko ime!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: telefon,
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        } else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                          return 'Neispravan format!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        telefon = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: mail,
                      decoration: const InputDecoration(labelText: 'Mail'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite mail mualima';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Neispravan format maila!';
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
                   //DropdownButtonFormField<String>(
                   //  decoration: const InputDecoration(labelText: 'Status'),
                   //  value: status,
                   //  items: ['Aktivan', 'Neaktivan'].map((String value) {
                   //    return DropdownMenuItem<String>(
                   //      value: value,
                   //      child: Text(value),
                   //    );
                   //  }).toList(),
                   //  onChanged: (newValue) {
                   //    status = newValue!;
                   //  },
                   //  validator: (value) {
                   //    if (value == null || value.isEmpty) {
                   //      return 'Unesite status!';
                   //    }
                   //    return null;
                   //  },
                   //),
                    TextFormField(
                      controller: datumRodjenjaController,
                      decoration: const InputDecoration(labelText: 'Datum rođenja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite datum rođenja!';
                        }
                        return null;
                      },
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: datumRodjenja,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != datumRodjenja) {
                          datumRodjenja = picked;
                          datumRodjenjaController.text = datumRodjenja!.toLocal().toString().split(' ')[0];
                        }
                      },
                    ),
                    TextFormField(
                      initialValue: imeRoditelja,
                      decoration: const InputDecoration(labelText: 'Ime roditelja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime jednog roditelja!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        imeRoditelja = value!;
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
                  bool result = await provider.update(
                    userId,
                    ime!,
                    prezime!,
                    username!,
                    telefon!,
                    mail!,
                    spol!,
                    datumRodjenja!,
                    imeRoditelja!,
                    mektebId,
                  );
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Komisija uspješno ažurirana')),
                    );
                    fetchDataKomisija();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri ažuriranju komisije')),
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
  void _showUpdateFormSuperAdmin(BuildContext context, SuperAdminProvider provider, int? userId, SuperAdmin userData) {
    final formKey = GlobalKey<FormState>();
    String? ime = userData.ime;
    String? prezime = userData.prezime;
    String? username = userData.username;
    String? telefon = userData.telefon;
    String? mail = userData.mail;
    String? spol = userData.spol;
   // String? status = userData.status;
    DateTime? datumRodjenja = userData.datumRodjenja;
    String? imeRoditelja = userData.imeRoditelja;
    int? mektebId = userData.mektebId;

    final TextEditingController datumRodjenjaController = TextEditingController();
    datumRodjenjaController.text = datumRodjenja!.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uredi podatke za super admina'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: ime,
                      decoration: const InputDecoration(labelText: 'Ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ime je obavezno!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ime = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: prezime,
                      decoration: const InputDecoration(labelText: 'Prezime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Prezime je obavezno!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        prezime = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: username,
                      decoration: const InputDecoration(labelText: 'Korisničko ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite korisničko ime!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: telefon,
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        } else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                          return 'Neispravan format!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        telefon = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: mail,
                      decoration: const InputDecoration(labelText: 'Mail'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite mail mualima';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Neispravan format maila!';
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
                   //DropdownButtonFormField<String>(
                   //  decoration: const InputDecoration(labelText: 'Status'),
                   //  value: status,
                   //  items: ['Aktivan', 'Neaktivan'].map((String value) {
                   //    return DropdownMenuItem<String>(
                   //      value: value,
                   //      child: Text(value),
                   //    );
                   //  }).toList(),
                   //  onChanged: (newValue) {
                   //    status = newValue!;
                   //  },
                   //  validator: (value) {
                   //    if (value == null || value.isEmpty) {
                   //      return 'Unesite status!';
                   //    }
                   //    return null;
                   //  },
                   //),
                    TextFormField(
                      controller: datumRodjenjaController,
                      decoration: const InputDecoration(labelText: 'Datum rođenja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite datum rođenja!';
                        }
                        return null;
                      },
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: datumRodjenja,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != datumRodjenja) {
                          datumRodjenja = picked;
                          datumRodjenjaController.text = datumRodjenja!.toLocal().toString().split(' ')[0];
                        }
                      },
                    ),
                    TextFormField(
                      initialValue: imeRoditelja,
                      decoration: const InputDecoration(labelText: 'Ime roditelja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime jednog roditelja!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        imeRoditelja = value!;
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
                  bool result = await provider.update(
                    userId,
                    ime!,
                    prezime!,
                    username!,
                    telefon!,
                    mail!,
                    spol!,
                    datumRodjenja!,
                    imeRoditelja!,
                    mektebId,
                  );
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Super admin uspješno ažuriran')),
                    );
                    fetchDataSuperAdmin();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri ažuriranju!')),
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

}
