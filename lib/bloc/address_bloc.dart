import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tokotok/firebase/address_database.dart';
import 'package:tokotok/firebase/auth_services.dart';
import 'package:tokotok/models/address.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial());

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    if (event is LoadAddress) {
      if (state is AddressLoaded) {
        yield AddressInitial();
      }
      List<Address> address = [];
      User user = await AuthServices.getCurrentUser();

      List<QueryDocumentSnapshot> docs =
          await AddressDatabase.getAddress(user.uid);
      for (var i = 0; i < docs.length; i++) {
        address.add(Address(
            id: docs[i].id,
            name: docs[i]["name"],
            address: docs[i]["address"],
            noTelp: docs[i]["noTelp"],
            provinsi: docs[i]["provinsi"]));
      }
      yield AddressLoaded(address: address);
    }
  }
}
