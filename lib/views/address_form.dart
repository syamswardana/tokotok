import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokotok/bloc/address_bloc.dart';
import 'package:tokotok/firebase/address_database.dart';
import 'package:tokotok/firebase/auth_services.dart';
import 'package:tokotok/models/address.dart';
import 'package:tokotok/views/custom_theme.dart';

// ignore: must_be_immutable
class AddressForm extends StatelessWidget {
  final Address address;
  TextEditingController nameController;
  TextEditingController noTelpController;
  String selectedProvinsi;
  TextEditingController addressController;
  AddressForm({this.address}) {
    nameController =
        TextEditingController(text: address != null ? address.name : "");
    noTelpController =
        TextEditingController(text: address != null ? address.noTelp : "");
    selectedProvinsi = address != null ? address.provinsi : null;
    addressController =
        TextEditingController(text: address != null ? address.address : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: CustomTheme.Background,
        title: Text(
          address != null ? "Edit Alamat" : "Tambah Alamat",
          style: TextStyle(color: CustomTheme.Dark),
        ),
        leading: BackButton(
          color: CustomTheme.Grey,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          User user = await AuthServices.getCurrentUser();
          if (nameController.text != "" &&
              noTelpController.text != "" &&
              selectedProvinsi != null &&
              addressController.text != "") {
            if (address != null) {
              AddressDatabase.updateAddress(address.id, {
                "name": nameController.text,
                "noTelp": noTelpController.text,
                "provinsi": selectedProvinsi,
                "address": addressController.text,
                "uid": user.uid,
              }).then((value) {
                BlocProvider.of<AddressBloc>(context).add(LoadAddress());
                Navigator.pop(context);
              }).onError((error, stackTrace) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Gagal")));
              });
            } else {
              AddressDatabase.addAddress({
                "name": nameController.text,
                "noTelp": noTelpController.text,
                "provinsi": selectedProvinsi,
                "address": addressController.text,
                "uid": user.uid,
              }).then((value) {
                BlocProvider.of<AddressBloc>(context).add(LoadAddress());
                Navigator.pop(context);
              }).onError((error, stackTrace) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Gagal")));
              });
            }
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Lengkapi data")));
          }
        },
        child: Text("Simpan"),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(CustomTheme.Blue),
            minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width - 40, 50))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nama"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFormField(
                controller: noTelpController,
                decoration: InputDecoration(labelText: "Nomor Telepon"),
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: DropdownButtonFormField(
                  isDense: true,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      child: Text("Jawa Timur"),
                      value: "Jawa Timur",
                    ),
                    DropdownMenuItem(
                      child: Text("Jawa Tengah"),
                      value: "Jawa Tengah",
                    ),
                    DropdownMenuItem(
                        child: Text("Jawa Barat"), value: "Jawa Barat"),
                    DropdownMenuItem(
                      child: Text("Bali"),
                      value: "Bali",
                    ),
                  ],
                  value: selectedProvinsi,
                  onChanged: (item) {
                    selectedProvinsi = item;
                  },
                  decoration: InputDecoration(labelText: "Provinsi"),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Alamat"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
