import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/obavijest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/obavijest_provider.dart';
import '../providers/user_provider.dart';
void main() {
  runApp(const ObavijestEdit(
    obavijest: null,
  ));
}

class ObavijestEdit extends StatefulWidget {
  final Obavijest? obavijest;

  const ObavijestEdit({super.key, this.obavijest});

  @override
  State<ObavijestEdit> createState() => _ObavijestEditState();
}

class _ObavijestEditState extends State<ObavijestEdit> {
  final _formKey = GlobalKey<FormState>();
  late UserProvider _userProvider;
  late ObavijestProvider _obavijestProvider;
  late String naslov;
  late String opis;
  late DateTime datumObjave;
  late int? id;

  @override
  void initState() {
    super.initState();
    id = widget.obavijest?.id ?? 1;
    naslov = widget.obavijest?.naslov ?? '';
    opis = widget.obavijest?.opis ?? '';
    datumObjave = widget.obavijest?.datumObjave ?? DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _obavijestProvider= context.read<ObavijestProvider>();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Obavijest - admin",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            nazivSection(),
            divider(),
            formSection(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget nazivSection() {
    return const Padding(
      padding: EdgeInsets.only(top: 25.0, bottom: 20.0),
      child: Center(
        child: Text(
          "Uredi obavijest",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget divider() {
    return SizedBox(
      width: 280, 
      child: Divider(
        color: Colors.yellow.shade600, 
        thickness: 3, 
      ),
    );
  }

  Widget formSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: naslov,
            decoration: const InputDecoration(labelText: 'Naslov'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite naslov';
              }
              return null;
            },
            onSaved: (value) {
              naslov = value!;
            },
          ),
          TextFormField(
            initialValue: opis,
            decoration: const InputDecoration(labelText: 'Opis'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite Opis';
              }
              return null;
            },
            onSaved: (value) {
              opis = value!;
            },
            minLines: 1,
            maxLines: null,
          ),
        ],
      ),
    );
  }

  Widget saveButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            try {
              bool result = await _obavijestProvider.update(id, opis, datumObjave, naslov);
              if (result) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Obavijest uspješno uređena.')),
                );
                Navigator.of(context).pop(true);
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          }
        },
        child: const Text(
          'SPASI',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
