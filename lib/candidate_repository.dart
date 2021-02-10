//import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'candidate_model.dart';

class CandidateRepository {
  Future<List<Candidate>> listCandidate() async {
    final String rpcUrl = 'http://192.168.100.3:7545';
    final String wsUrl = 'ws://192.168.100.3:7545';
    //final File abiFile = File('assets/Election.abi');
    final EthereumAddress contractAddr =
        EthereumAddress.fromHex('0xd7aac401004aE52F52C804C17202d79dd198D43e');
    final client = Web3Client(rpcUrl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
    //final abiCode = await abiFile.readAsString();
    final abiCode = await rootBundle.loadString("assets/Election.abi").then((value) => value);
    final contract = DeployedContract(
        ContractAbi.fromJson(abiCode, 'Election'), contractAddr);
    final candidatesCountFunction = contract.function('candidatesCount');
    final candidatesCount = await client.call(
      contract: contract,
      function: candidatesCountFunction,
      params: [],
    );

    final count = int.parse(candidatesCount.first.toString());

    final candidatesFunction = contract.function('candidates');
    var json = Map<String, dynamic>();
    var candidates = <Candidate>[];
    for (var i = 1; i <= count; i++) {
      final candidate = await client.call(
        contract: contract,
        function: candidatesFunction,
        params: [BigInt.from(i)],
      );
      json['ID'] = int.parse(candidate.elementAt(0).toString());
      json['Name'] = candidate.elementAt(1).toString();
      json['Votes'] = int.parse(candidate.elementAt(2).toString());
      var candidateObj = Candidate.fromJson(json);
      candidates.add(candidateObj);
    }
      return candidates;
  }
}
