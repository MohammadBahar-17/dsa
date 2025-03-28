class HuffmanNode {
  String? character;
  int frequency;
  HuffmanNode? left;
  HuffmanNode? right;
  HuffmanNode(this.character, this.frequency, {this.left, this.right});
}

class HuffmanCoding {
  late Map<String, String> huffmanCode;
  HuffmanNode? root;

  void buildHuffmanTree(Map<String, int> frequencyMap) {
    List<HuffmanNode> nodes = frequencyMap.entries
        .map((entry) => HuffmanNode(entry.key, entry.value))
        .toList();

    while (nodes.length > 1) {
      nodes.sort((a, b) => a.frequency.compareTo(b.frequency));

      HuffmanNode left = nodes.removeAt(0);
      HuffmanNode right = nodes.removeAt(0);

      int combinedFrequency = left.frequency + right.frequency;
      HuffmanNode parentNode =
          HuffmanNode(null, combinedFrequency, left: left, right: right);
      nodes.add(parentNode);
    }

    root = nodes.first;
    huffmanCode = _generateCodes(root, "");
  }

  Map<String, String> _generateCodes(HuffmanNode? node, String code) {
    Map<String, String> codes = {};
    if (node == null) return codes;

    if (node.character != null) {
      codes[node.character!] = code;
    } else {
      codes.addAll(_generateCodes(node.left, code + "0"));
      codes.addAll(_generateCodes(node.right, code + "1"));
    }

    return codes;
  }

  String encode(String text) {
    return text.split('').map((char) => huffmanCode[char] ?? "").join();
  }

  String decode(String encodedText) {
    StringBuffer decodedText = StringBuffer();
    HuffmanNode? currentNode = root;

    for (var bit in encodedText.split('')) {
      currentNode = (bit == '0') ? currentNode?.left : currentNode?.right;

      if (currentNode?.character != null) {
        decodedText.write(currentNode!.character);
        currentNode = root;
      }
    }

    return decodedText.toString();
  }
}

void main() {
  Map<String, int> frequencyMap = {
    'a': 5,
    'b': 9,
    'c': 12,
    'd': 13,
    'e': 16,
    'f': 45,
  };

  HuffmanCoding huffman = HuffmanCoding();
  huffman.buildHuffmanTree(frequencyMap);

  print("Huffman Codes: ${huffman.huffmanCode}");

  String text = "abcdef";
  String encodedText = huffman.encode(text);
  print("Encoded Text: $encodedText");

  String decodedText = huffman.decode(encodedText);
  print("Decoded Text: $decodedText");
}
