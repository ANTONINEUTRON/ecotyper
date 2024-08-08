import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ecotyper/features/gameplay/data/model/fact.dart';
import 'package:ecotyper/features/gameplay/data/model/levels.dart';
import 'package:ecotyper/features/gameplay/data/model/sections.dart';
import 'package:ecotyper/gen/env.dart';
import 'package:uuid/uuid.dart';

/// Here is a fun fact in JSON format, including a prologue (not more than 40 words) related to Society & Psychology and a factual body (between 150 - 200 words)
// { "prologue": "", "fact": "" }
class GeminiProvider {
  // For text-only input, use the gemini-pro model
  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: Env.geminiKey,
  );

  Future<Fact> getFact({
    required Sections section,
    required Levels levels,
  }) async {
    final content = [
      Content.text("""
  Write a $section fact in JSON format as plain text while removing all markdown formatting. 

  The JSON object should have two keys:

  * prologue (length: under 40 words): A concise introduction related to the fact.
  * fact (length: ${levels.rangeOfValue} words): The fact in a clear and informative way.
  """),
      // Content.text(
      //     "Write a $section fact in JSON format. The JSON object should have two keys: prologue (length: under 40 words): A concise introduction related to the fact; and fact (length: ${levels.rangeOfValue} words): The fact in a clear and informative way"),
      // Content.text(
      //     "Here is a fun fact in JSON format as plain text and no formatting. provide a fact related to $section, include a prologue (not more than 40 words) and an associated factual body with word length between ${levels.rangeOfValue} words { \"prologue\": "
      //     ", \"fact\": "
      //     " }")
    ];
    print(content.first.parts.first);
    final response = await model.generateContent(content);
    String responseText = _removeAllCharacters(text: response.text!);
    print(responseText);
    Map<String, dynamic> passageAsJson = jsonDecode(responseText);
    return Fact(
      id: const Uuid().v1(),
      fact: passageAsJson["fact"],
      prologue: passageAsJson["prologue"],
      lastAccessedTime: DateTime.now(),
      section: section,
      level: levels,
    );
  }

  String _removeAllCharacters({required String text}) {
    return text.substring(text.indexOf("{"), text.indexOf("}") + 1);
  }
}
