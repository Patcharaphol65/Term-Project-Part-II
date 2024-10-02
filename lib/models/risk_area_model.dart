import 'dart:convert';

RiskArea RiskAreaFromJson(String str) => RiskArea.fromJson(json.decode(str));

String RiskAreaToJson(RiskArea data) => json.encode(data.toJson());

class RiskArea {
    String id;
    String name;
    String riskLevel;
    String location;
    String dangerType;
    String description;
    double lat;
    double long;

    RiskArea({
        required this.id,
        required this.name,
        required this.riskLevel,
        required this.location,
        required this.dangerType,
        required this.description,
        required this.lat,
        required this.long,
    });

    factory RiskArea.fromJson(Map<String, dynamic> json) => RiskArea(
        id: json["id"],
        name: json["name"],
        riskLevel: json["riskLevel"],
        location: json["location"],
        dangerType: json["dangerType"],
        description: json["description"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "riskLevel": riskLevel,
        "location": location,
        "dangerType": dangerType,
        "description": description,
        "lat": lat,
        "long": long,
    };
}