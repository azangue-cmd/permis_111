import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/provier/address_provider.dart';
import '../../../model/address_model.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key
  });

 

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      
      child: 
      Consumer<AddressProvider>(builder: (context, addresPovider, child){
        if(addresPovider.fetchedCurrentSelectedAddress == true){
          AddressModel selectedAddress = addresPovider.currentSelectedAddress;
          return ListTile(
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white24,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
      
        ),
        title: Text(
          '${selectedAddress.name}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      );
        }else{
          return const ListTile(
        leading:  CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white24,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
      
        ),
        title: Text(
          'Nom Utilisateur',
          style:  TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      );
        }
      }
      
    ));
  }
}