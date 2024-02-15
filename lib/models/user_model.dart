import 'package:cloud_firestore/cloud_firestore.dart';

class ScortModel {
  final String scortID;
  final String name;
  final String description;
  final String category;
  final double rating;
  final double hourlyRate;
  final List<String> availability;
  final GeoPoint location;
  final List<String> servicesOffered;
  final Map<String, dynamic> physicalAttributes;
  final List<String> personalityTraits;
  final List<String> photos;

  ScortModel({
    required this.scortID,
    required this.name,
    required this.description,
    required this.category,
    required this.rating,
    required this.hourlyRate,
    required this.availability,
    required this.location,
    required this.servicesOffered,
    required this.physicalAttributes,
    required this.personalityTraits,
    required this.photos,
  });

  Map<String, dynamic> toMap() {
    return {
      'scortID': scortID,
      'name': name,
      'description': description,
      'category': category,
      'rating': rating,
      'hourlyRate': hourlyRate,
      'availability': availability,
      'location': location,
      'servicesOffered': servicesOffered,
      'physicalAttributes': physicalAttributes,
      'personalityTraits': personalityTraits,
      'photos': photos,
    };
  }

  // Convert a Map into a ScortModel object
  static ScortModel fromMap(Map<String, dynamic> map) {
    return ScortModel(
      scortID: map['scortID'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      rating: map['rating'],
      hourlyRate: map['hourlyRate'],
      availability: List<String>.from(map['availability']),
      location: map['location'],
      servicesOffered: List<String>.from(map['servicesOffered']),
      physicalAttributes: Map<String, dynamic>.from(map['physicalAttributes']),
      personalityTraits: List<String>.from(map['personalityTraits']),
      photos: List<String>.from(map['photos']),
    );
  }
}
