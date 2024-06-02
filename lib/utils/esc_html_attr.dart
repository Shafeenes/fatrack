class EscHtmlAttr {
  String htmlstr;
  EscHtmlAttr({required this.htmlstr});

  String getConvertedHtml() {
    // String textVal = "";
    // RegExp htmlRegex = RegExp(r"<(img|a)[^>]*>(?<content>[^<]*)<");
    final regex = RegExp(r"<(img|a)[^>]*>(?<content>[^<]*)<", multiLine: true);
    return htmlstr.replaceAll(regex, "");
  }
}
