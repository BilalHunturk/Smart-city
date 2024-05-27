import 'package:bocekilaclama/core/base/base_models.dart';

class RouteModel extends IBaseModel {
  final String? code;
  final List<Route>? routes;
  final List<Waypoint>? waypoints;

  RouteModel({
    this.code,
    this.routes,
    this.waypoints,
  });

  Map<String, dynamic> toJson() => {
        "code": code,
        "routes": routes == null
            ? []
            : List<dynamic>.from(routes!.map((x) => x.toJson())),
        "waypoints": waypoints == null
            ? []
            : List<dynamic>.from(waypoints!.map((x) => x.toJson())),
      };

  @override
  fromJson(Map<String, dynamic> json) => RouteModel(
        code: json["code"],
        routes: json["routes"] == null
            ? []
            : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
        waypoints: json["waypoints"] == null
            ? []
            : List<Waypoint>.from(
                json["waypoints"]!.map((x) => Waypoint.fromJson(x))),
      );
}

class Route {
  final Geometry? geometry;
  final List<Leg>? legs;
  final String? weightName;
  final double? weight;
  final double? duration;
  final double? distance;

  Route({
    this.geometry,
    this.legs,
    this.weightName,
    this.weight,
    this.duration,
    this.distance,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        legs: json["legs"] == null
            ? []
            : List<Leg>.from(json["legs"]!.map((x) => Leg.fromJson(x))),
        weightName: json["weight_name"],
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry?.toJson(),
        "legs": legs == null
            ? []
            : List<dynamic>.from(legs!.map((x) => x.toJson())),
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
      };
}

class Geometry {
  final List<List<double>>? coordinates;
  final String? type;

  Geometry({
    this.coordinates,
    this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null
            ? []
            : List<List<double>>.from(json["coordinates"]!
                .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(
                coordinates!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "type": type,
      };
}

class Leg {
  final List<Step>? steps;
  final String? summary;
  final double? weight;
  final double? duration;
  final Annotation? annotation;
  final double? distance;

  Leg({
    this.steps,
    this.summary,
    this.weight,
    this.duration,
    this.annotation,
    this.distance,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        steps: json["steps"] == null
            ? []
            : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
        summary: json["summary"],
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        annotation: json["annotation"] == null
            ? null
            : Annotation.fromJson(json["annotation"]),
        distance: json["distance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "steps": steps == null
            ? []
            : List<dynamic>.from(steps!.map((x) => x.toJson())),
        "summary": summary,
        "weight": weight,
        "duration": duration,
        "annotation": annotation?.toJson(),
        "distance": distance,
      };
}

class Annotation {
  final Metadata? metadata;
  final List<int>? datasources;
  final List<double>? weight;
  final List<int>? nodes;
  final List<double>? distance;
  final List<double>? duration;
  final List<double>? speed;

  Annotation({
    this.metadata,
    this.datasources,
    this.weight,
    this.nodes,
    this.distance,
    this.duration,
    this.speed,
  });

  factory Annotation.fromJson(Map<String, dynamic> json) => Annotation(
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        datasources: json["datasources"] == null
            ? []
            : List<int>.from(json["datasources"]!.map((x) => x)),
        weight: json["weight"] == null
            ? []
            : List<double>.from(json["weight"]!.map((x) => x?.toDouble())),
        nodes: json["nodes"] == null
            ? []
            : List<int>.from(json["nodes"]!.map((x) => x)),
        distance: json["distance"] == null
            ? []
            : List<double>.from(json["distance"]!.map((x) => x?.toDouble())),
        duration: json["duration"] == null
            ? []
            : List<double>.from(json["duration"]!.map((x) => x?.toDouble())),
        speed: json["speed"] == null
            ? []
            : List<double>.from(json["speed"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata?.toJson(),
        "datasources": datasources == null
            ? []
            : List<dynamic>.from(datasources!.map((x) => x)),
        "weight":
            weight == null ? [] : List<dynamic>.from(weight!.map((x) => x)),
        "nodes": nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x)),
        "distance":
            distance == null ? [] : List<dynamic>.from(distance!.map((x) => x)),
        "duration":
            duration == null ? [] : List<dynamic>.from(duration!.map((x) => x)),
        "speed": speed == null ? [] : List<dynamic>.from(speed!.map((x) => x)),
      };
}

class Metadata {
  final List<String>? datasourceNames;

  Metadata({
    this.datasourceNames,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        datasourceNames: json["datasource_names"] == null
            ? []
            : List<String>.from(json["datasource_names"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "datasource_names": datasourceNames == null
            ? []
            : List<dynamic>.from(datasourceNames!.map((x) => x)),
      };
}

class Step {
  final Geometry? geometry;
  final Maneuver? maneuver;
  final String? mode;
  final String? drivingSide;
  final String? name;
  final List<Intersection>? intersections;
  final double? weight;
  final double? duration;
  final double? distance;

  Step({
    this.geometry,
    this.maneuver,
    this.mode,
    this.drivingSide,
    this.name,
    this.intersections,
    this.weight,
    this.duration,
    this.distance,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        maneuver: json["maneuver"] == null
            ? null
            : Maneuver.fromJson(json["maneuver"]),
        mode: json["mode"],
        drivingSide: json["driving_side"],
        name: json["name"],
        intersections: json["intersections"] == null
            ? []
            : List<Intersection>.from(
                json["intersections"]!.map((x) => Intersection.fromJson(x))),
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry?.toJson(),
        "maneuver": maneuver?.toJson(),
        "mode": mode,
        "driving_side": drivingSide,
        "name": name,
        "intersections": intersections == null
            ? []
            : List<dynamic>.from(intersections!.map((x) => x.toJson())),
        "weight": weight,
        "duration": duration,
        "distance": distance,
      };
}

class Intersection {
  final int? out;
  final List<bool>? entry;
  final List<int>? bearings;
  final List<double>? location;
  final int? intersectionIn;

  Intersection({
    this.out,
    this.entry,
    this.bearings,
    this.location,
    this.intersectionIn,
  });

  factory Intersection.fromJson(Map<String, dynamic> json) => Intersection(
        out: json["out"],
        entry: json["entry"] == null
            ? []
            : List<bool>.from(json["entry"]!.map((x) => x)),
        bearings: json["bearings"] == null
            ? []
            : List<int>.from(json["bearings"]!.map((x) => x)),
        location: json["location"] == null
            ? []
            : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
        intersectionIn: json["in"],
      );

  Map<String, dynamic> toJson() => {
        "out": out,
        "entry": entry == null ? [] : List<dynamic>.from(entry!.map((x) => x)),
        "bearings":
            bearings == null ? [] : List<dynamic>.from(bearings!.map((x) => x)),
        "location":
            location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
        "in": intersectionIn,
      };
}

class Maneuver {
  final int? bearingAfter;
  final int? bearingBefore;
  final List<double>? location;
  final String? type;

  Maneuver({
    this.bearingAfter,
    this.bearingBefore,
    this.location,
    this.type,
  });

  factory Maneuver.fromJson(Map<String, dynamic> json) => Maneuver(
        bearingAfter: json["bearing_after"],
        bearingBefore: json["bearing_before"],
        location: json["location"] == null
            ? []
            : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "bearing_after": bearingAfter,
        "bearing_before": bearingBefore,
        "location":
            location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
        "type": type,
      };
}

class Waypoint {
  final String? hint;
  final double? distance;
  final String? name;
  final List<double>? location;

  Waypoint({
    this.hint,
    this.distance,
    this.name,
    this.location,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        hint: json["hint"],
        distance: json["distance"]?.toDouble(),
        name: json["name"],
        location: json["location"] == null
            ? []
            : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "hint": hint,
        "distance": distance,
        "name": name,
        "location":
            location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
      };
}
