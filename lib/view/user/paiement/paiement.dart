import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/controller/services/users_product_services/users_product_servives.dart';
import 'package:permis_111/model/product_model.dart';
import 'package:permis_111/model/transaction_model.dart';
import 'package:uuid/uuid.dart';
import '../../../controller/services/notch_pay_services/notch_pay_service.dart';
import '../../../model/user_product_model.dart';
import '../../../utils/colors.dart';
import '../../direction_screen/direction_screnn.dart';

class PaymentScreen extends StatefulWidget {
  final String cartTotalProduct;
  final List<UserProductModel> prodoctsModelLists;
  PaymentScreen({super.key, required this.cartTotalProduct, required this.prodoctsModelLists});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // String secretKey = '';
  //  String publicKey = '';
  String phoneController = '';

  // TextEditingController emailController = TextEditingController();
  //  TextEditingController amountController = TextEditingController();
  //TextEditingController phoneController = TextEditingController();
  //TextEditingController referenceController = TextEditingController();
  // TextEditingController desciptionController = TextEditingController();

  // Future<void> InitiatePayment() async {
  //   try {
  //     final paymentParams = {
  //       'email': emailController.text,
  //       'currency': 'XAF',
  //       'amount': amountController.text,
  //       'phone': phoneController,
  //       'reference': referenceController.text,
  //       'description': desciptionController.text,
  //     };
  //     final response = await http.post(
  //       Uri.parse('https://api.notchpay.co/payments/initialize'),
  //       headers: {
  //         'Authorization':
  //             secretKey, // Utiliser la clé secrète pour l'authentification
  //         'Accept': 'application/json',
  //       },
  //       body: paymentParams,
  //     );
  //     // Analyser le corps de la réponse comme du JSON
  //     final responseBody = jsonDecode(response.body);

  //     // Vérifier le code de statut de la réponse
  //     if (response.statusCode == 200) {
  //       // Initialisation du paiement réussie
  //       // Récupérer l'URL du paiement dans le corps de la réponse
  //       final paymentUrl = responseBody['data']['url'];

  //       // Rediriger l'utilisateur vers l'URL du paiement
  //       // Vous pouvez utiliser le plugin url_launcher pour lancer l'URL dans un navigateur web
  //       // https://pub.dev/packages/url_launcher
  //     } else {
  //       // Initialisation du paiement échouée
  //       // Récupérer le message d'erreur dans le corps de la réponse
  //       final errorMessage = responseBody['message'];

  //       // Afficher le message d'erreur à l'utilisateur
  //       // Vous pouvez utiliser le plugin fluttertoast pour afficher un message toast
  //       // https://pub.dev/packages/fluttertoast
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    var notchPayService = NotchPayService(/*
        'sb.ioSUaNKW0X89GKNyf47WHk5yidfi6T1iBnXYlfyp73UviCGNlYuVgZqk6A8skh6saa5vIxnuQbENIKETtmlDmFNhQ4lcSEpfs6RW5WkgOqKjQyrHs9ItIoeUkLYAC'*/);

    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(width, height * 0.10),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.02),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: appBarGradientColor,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: const AssetImage(
                      'assets/images/permis111_5.png',
                    ),
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ),
          // appBar: AppBar(
          //   title: const Center(child: Text('Formulaire de Paiement')),
          // ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonFunction.blankSpace(height * 0.04, 0),
                  Center(
                      child: Text('Effectuer votre Paiement',
                          style: textTheme.headline1)),
                  CommonFunction.blankSpace(height * 0.04, 0),
                  // TextFormField(
                  //   controller: emailController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Email',
                  //     hintText: 'Entrez votre email',
                  //     hintStyle: textTheme.bodyMedium!.copyWith(
                  //       color: Colors.grey,
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //   ),
                  //   style: textTheme.displaySmall,
                  //   keyboardType: TextInputType.emailAddress,
                  //   textInputAction: TextInputAction.next,
                  // ),
                  SizedBox(
                    height: height * 0.12,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text:
                                          'Vous voulez effectuer un payement de  ',
                                      style: textTheme.bodyMedium!
                                          .copyWith(fontSize: 15),
                                    ),
                                    TextSpan(
                                      text: '${widget.cartTotalProduct} frcs',
                                      style: textTheme.bodyLarge!.copyWith(
                                          color: teal,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            ' correspondant au prix total de votre commande.',
                                        style: textTheme.bodyMedium!
                                            .copyWith(fontSize: 14)),
                                  ])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CommonFunction.blankSpace(height * 0.02, 0),
                  Text(
                    'Veillez saisir votre numero de telephone',
                    style: textTheme.bodyMedium!.copyWith(fontSize: 15),
                  ),
                  // TextFormField(
                  //   controller: amountController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Montant',
                  //     hintText: 'Entrez le montant à payer',
                  //     hintStyle: textTheme.bodyMedium!.copyWith(
                  //       color: Colors.grey,
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //   ),
                  // ),
                  CommonFunction.blankSpace(height * 0.015, 0),
                  //  TextFormField(
                  //   controller: phoneController,
                  //   decoration:  InputDecoration(
                  //     labelText: 'Téléphone',
                  //     hintText: 'Entrez votre numéro de téléphone',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  IntlPhoneField(
                    initialCountryCode: "CM",
                    onChanged: (value) {
                      print(value.completeNumber);
                      phoneController = value.completeNumber;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    style: textTheme.displaySmall,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  CommonFunction.blankSpace(height * 0.015, 0),
                  // TextFormField(
                  //   controller: referenceController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Référence',
                  //     hintText: 'Entrez la référence de la transaction',
                  //     hintStyle: textTheme.bodyMedium!.copyWith(
                  //       color: Colors.grey,
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //   ),
                  //   style: textTheme.displaySmall,
                  //  // keyboardType: TextInputType.number,
                  //   textInputAction: TextInputAction.next,
                  // ),
                  // CommonFunction.blankSpace(height * 0.015, 0),
                  // TextFormField(
                  //   controller: desciptionController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Description',
                  //     hintText: 'Entrez la description de la transaction',
                  //     hintStyle: textTheme.bodyMedium!.copyWith(
                  //       color: Colors.grey,
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //   ),
                  //   style: textTheme.displaySmall,
                  //  // keyboardType: TextInputType.number,
                  //   textInputAction: TextInputAction.next,
                  // ),
                  CommonFunction.blankSpace(height * 0.02, 0),

                  ElevatedButton(
                    onPressed: () async {
                      
                      final uuid = Uuid();
                      var reference = uuid.v1() + uuid.v4();
                      await notchPayService.saveTransaction(TransactionModel(
                        reference: reference,
                      ));
                      var response = await notchPayService.initializePayment(
                        email: 'ulrichazangue@gmail.com',
                        currency: 'XAF',
                        amount: widget.cartTotalProduct,
                        phone: phoneController,
                        reference: reference,
                        description: 'tester le paiement',
                      );
                    final transact = TransactionModel.fromMap(response);
                    if (transact.sndStatus == 'pending'){
                      for (var product in widget.prodoctsModelLists) {
                        product.reference = reference;
                        await UsersProductService.addOrder(context: context, productModel: product);
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                                  context,
                                  PageTransition(
                                    child: DirectionScrennWeb(url:transact.authorizationUrl!),
                                    type: PageTransitionType.rightToLeft,
                                  )
                                  );
                    }
                     
                      print(phoneController);
                    },
                    child: const Text('Payer'),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
