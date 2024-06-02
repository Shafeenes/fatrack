class DomainEvent {
  int id;
  bool isPublished;
  String dateOccurred;

  DomainEvent(
      {this.id = 0, required this.isPublished, required this.dateOccurred});

  static DomainEvent fromJson(dynamic json) {
    return DomainEvent(
      id: json["id"],
      isPublished: json["isPublished"],
      dateOccurred: json["dateOccurred"],
    );
  }

  Map<String, dynamic> toJson(DomainEvent domainEvent) {
    Map<String, dynamic> domainEventJson = {};

    domainEventJson["id"] = domainEvent.id;
    domainEventJson["isPublished"] = domainEvent.isPublished;
    domainEventJson["dateOccurred"] = domainEvent.dateOccurred;

    return domainEventJson;
  }

  static List<DomainEvent> toList(dynamic domainEventsJson) {
    List<DomainEvent> domainEvents = [];
    if (domainEventsJson.length > 0) {
      domainEventsJson.forEach((domainEvent) {
        domainEventsJson.add(fromJson(domainEvent));
      });
    }

    return domainEvents;
  }
}
