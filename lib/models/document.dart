class Document {
  int id;
  String documentName;
  String documentUrl;
  int ticketsId;

  Document(
      {this.id = 0,
      required this.documentName,
      required this.documentUrl,
      required this.ticketsId});

  static Document fromJson(dynamic json) {
    return Document(
      id: json["id"],
      documentName: json["documentName"],
      documentUrl: json["documentUrl"],
      ticketsId: json["ticketsId"],
    );
  }

  static Map<String, dynamic> toJson(Document document) {
    Map<String, dynamic> documentJson = {};

    documentJson["id"] = document.id;
    documentJson["documentName"] = document.documentName;
    documentJson["documentUrl"] = document.documentUrl;
    documentJson["ticketsId"] = document.ticketsId;

    return documentJson;
  }

  static List<Document> toList(dynamic documentsJson) {
    List<Document> documents = [];
    if (documentsJson.length > 0) {
      documentsJson.forEach((element) {
        documents.add(fromJson(element));
      });
    }

    return documents;
  }
}
