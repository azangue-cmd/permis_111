import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? id;
  String? reference;
  String? authorizationUrl;
  String? status;
  String? sndStatus;

  TransactionModel({
    this.id,
    this.reference,
    this.authorizationUrl,
    this.status,
    this.sndStatus
  });

  toFirestore() {
    return {
      'id': id,
      'reference': reference,
    };
  }

  factory TransactionModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return TransactionModel(
      id: snapshot.id,
      reference: data?['reference'],
    );
  }

  factory TransactionModel.fromMap(Map<String, dynamic> data) {
    return TransactionModel(
      reference: data['merchant_reference'],
      authorizationUrl: data['authorization_url'],
      status: data['status'],
      sndStatus: data['transaction']?['status'],
    );
  }
}