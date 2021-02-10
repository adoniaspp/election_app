import 'package:election_ethereum/candidate_model.dart';
import 'package:flutter/foundation.dart';

import 'candidate_repository.dart';

class CandidateState with ChangeNotifier {
  List<Candidate> _candidates = [];

  List<Candidate> get candidates => _candidates;

  CandidateRepository candidateRepository = CandidateRepository();

  // ignore: missing_return
  Future<List<Candidate>> fetchCandidate() async{
   await candidateRepository.listCandidate().then((value) {
      _candidates = value;
      notifyListeners();
   });
  }
}
