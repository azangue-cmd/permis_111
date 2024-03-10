import 'dart:convert'; // Importation du package pour convertir les données en JSON
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart'
    as http;

import '../../../model/transaction_model.dart'; // Importation du package pour effectuer des requêtes HTTP

// Définition de la classe NotchPayService
class NotchPayService {
  final String publicKey = 'sb.ioSUaNKW0X89GKNyf47WHk5yidfi6T1iBnXYlfyp73UviCGNlYuVgZqk6A8skh6saa5vIxnuQbENIKETtmlDmFNhQ4lcSEpfs6RW5WkgOqKjQyrHs9ItIoeUkLYAC'; // Déclaration de la clé publique

  // Constructeur de la classe qui prend la clé publique en paramètre
  NotchPayService();

  // Méthode pour initialiser un paiement
  // Elle prend plusieurs paramètres requis et renvoie une Future de Map<String, dynamic>
  Future<Map<String, dynamic>> initializePayment({
    required String email,
    required String currency,
    required String amount,
    required String phone,
    required String reference,
    required String description,
  }) async {
    // Effectue une requête POST à l'API de NotchPay pour initialiser un paiement
    final response = await http.post(
      Uri.parse('https://api.notchpay.co/payments/initialize'),
      headers: {
        'Authorization':
            publicKey, // Utilise la clé publique pour l'autorisation
        'Accept': 'application/json', // Accepte les réponses au format JSON
      },
      body: {
        'email': email, // Email du payeur
        'currency': currency, // Devise du paiement
        'amount': amount, // Montant du paiement
        'phone': phone, // Numéro de téléphone du payeur
        'reference': reference, // Référence du paiement
        'description': description, // Description du paiement
      },
    );
    

    // Renvoie la réponse de l'API convertie en Map<String, dynamic>
    return json.decode(response.body);
  }

   Future<List<TransactionModel>> getApiTransactions() async {
    final response = await http.get(Uri.parse('https://api.notchpay.co/payments'), headers: {
      'Authorization': publicKey,
      'Accept': 'application/json',
    });

   try{
     var res = json.decode(response.body)['items'];

    var rese = res;

    return (res as List)
        .map((e) => TransactionModel.fromMap(e))
        .toList();
   }catch(e){
     print("dddddddddd $e");
   }
    return [];
  }

  // Methode d'enregistrement d'une transaction
Future<void> saveTransaction(TransactionModel transaction) async{
    await FirebaseFirestore.instance
        .collection('Transactions')
        .withConverter(fromFirestore: TransactionModel.fromFirestore, toFirestore: (TransactionModel model, _) => model.toFirestore())
        .add(transaction);
  }

    Future<List<TransactionModel>> getTransactions() async {
    return (await FirebaseFirestore.instance
        .collection('Transactions')
        .withConverter(fromFirestore: TransactionModel.fromFirestore, toFirestore: (TransactionModel model, _) => model.toFirestore())
        .get()).docs.map((e) => e.data()).toList();
  }

  // Méthode pour vérifier un paiement
  // Elle prend l'ID du paiement, le canal et le numéro de téléphone en paramètres
  // et renvoie une Future de Map<String, dynamic>
  Future<Map<String, dynamic>> verifyPayment(
      String paymentId, String channel, String phoneNumber) async {
    // Effectue une requête PUT à l'API de NotchPay pour vérifier un paiement
    final response = await http.put(
      Uri.parse('https://api.notchpay.co/payments/$paymentId'),
      headers: {
        'Authorization':
            publicKey, // Utilise la clé publique pour l'autorisation
        'Accept': 'application/json', // Accepte les réponses au format JSON
      },
      body: json.encode({
        'channel': channel, // Canal de paiement
        'data': {
          'phone': phoneNumber, // Numéro de téléphone du payeur
        },
      }),
    );

    // Renvoie la réponse de l'API convertie en Map<String, dynamic>
    return json.decode(response.body);
  }

  // Méthode pour compléter un paiement
  // Elle ne prend aucun paramètre et renvoie une Future de Map<String, dynamic>
  Future<Map<String, dynamic>> completePayment() async {
    // Effectue une requête GET à l'API de NotchPay pour compléter un paiement
    final response = await http.get(
      Uri.parse('https://api.notchpay.co/payments'),
      headers: {
        'Authorization':
            publicKey, // Utilise la clé publique pour l'autorisation
      },
    );

    // Renvoie la réponse de l'API convertie en Map<String, dynamic>
    return json.decode(response.body);
  }

  // Méthode pour lister les paiements
  // Elle prend l'ID du paiement en paramètre et renvoie une Future de Map<String, dynamic>
  Future<Map<String, dynamic>> listPayments(String paymentId) async {
    // Effectue une requête GET à l'API de NotchPay pour lister les paiements
    final response = await http.get(
      Uri.parse('https://api.notchpay.co/payments/$paymentId'),
      headers: {
        'Authorization':
            publicKey, // Utilise la clé publique pour l'autorisation
        'Accept': 'application/json', // Accepte les réponses au format JSON
      },
    );

    // Renvoie la réponse de l'API convertie en Map<String, dynamic>
    return json.decode(response.body);
  }
}


