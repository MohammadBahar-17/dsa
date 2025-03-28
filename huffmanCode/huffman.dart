class Node {
  String? symbol;
  double frequency;
  Node? left, right;

  Node(this.symbol, this.frequency, {this.left, this.right});

  bool get isLeaf => left == null && right == null;
}

class HuffmanEncoder {
  Map<String, String> encodingTable = {};
  Node? root;

  HuffmanEncoder(Map<String, double> frequencyMap) {
    if (frequencyMap.isEmpty) {
      throw ArgumentError("Frequency map cannot be empty.");
    }

    List<Node> nodes = frequencyMap.entries
        .map((entry) => Node(entry.key, entry.value))
        .toList();

    nodes.sort((a, b) => a.frequency.compareTo(b.frequency));

    while (nodes.length > 1) {
      var first = nodes.removeAt(0);
      var second = nodes.removeAt(0);
      var parent = Node(null, first.frequency + second.frequency,
          left: first, right: second);
      nodes.add(parent);
      nodes.sort((a, b) => a.frequency.compareTo(b.frequency));
    }

    root = nodes.first;
    _buildEncodingTable(root, "");
  }

  void _buildEncodingTable(Node? node, String code) {
    if (node == null) return;
    if (node.isLeaf && node.symbol != null) {
      encodingTable[node.symbol!] = code.isNotEmpty ? code : "0";
      return;
    }
    _buildEncodingTable(node.left, code + "0");
    _buildEncodingTable(node.right, code + "1");
  }

  String encode(String text) {
    return text.split('').map((char) => encodingTable[char] ?? "").join();
  }

  String decode(String binary) {
    var result = StringBuffer();
    Node? currentNode = root;

    for (var bit in binary.split('')) {
      currentNode = (bit == '0') ? currentNode?.left : currentNode?.right;
      if (currentNode != null && currentNode.isLeaf) {
        result.write(currentNode.symbol);
        currentNode = root;
      }
    }
    return result.toString();
  }
}

void main() {
  Map<String, double> frequencies = {'X': 0.1, 'Y': 0.15, 'Z': 0.3, 'W': 0.45};

  var huffman = HuffmanEncoder(frequencies);

  print("Generated Huffman Codes:");
  huffman.encodingTable.forEach((symbol, code) {
    print("'$symbol': $code");
  });

  // Encoding
  String inputText = "XYZ";
  String encodedText = huffman.encode(inputText);
  print("Encoded '$inputText': $encodedText");

  // Decoding
  String encodedBinary = "11001";
  print("Decoded '$encodedBinary': ${huffman.decode(encodedBinary)}");
}
