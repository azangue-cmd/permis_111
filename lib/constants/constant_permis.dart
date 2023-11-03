import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String keySecret = '<Razorpay Key Secrets>';
const String keyID = '<Razorpay Key ID>';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

List<String> categorisPermis = [
  'care',
  'chinoise',
  'finess',
  'love',
  'permis',
  'tv',
  'viva',
];

List<String> carouselPicturesPermis = [
  'permis1',
  'permis2',
  'permis3',
  'permis4',
  'permis5',
  'permis6',
  'permis7',
  'permis8',
];

List<String> permisTodaysDeals = [
  'sccplus',
  'image',
  'stc3',
  'stc',
  'superlife'
];

List<String> permisHeadphonesDeals = [
  'sccplus',
  'image',
  'stc3',
  'stc',
  'superlife'
];
List<String> permisClothingDealsList = [
  'kurta.png',
  'tops.png',
  't_shirts.png',
  'view_all.png',
];

List<String> permisCategories = [
  'care',
  'chinoise',
  'finess',
  'love',
  'permis',
  'tv',
  'viva',
];

List<String> clothingProductDealsList = [
  'sccplus',
  'image',
  'stc3',
  'stc',
  'superlife'
];

List<String> headphonesProductDeals = [
  'sccplus',
  'image',
  'stc3',
  'stc',
  'superlife'
];