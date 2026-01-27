import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:barakah_pantry/core/config/gemini_config.dart';
import 'package:barakah_pantry/core/errors/exceptions.dart';
import 'package:barakah_pantry/core/utils/logger.dart';

/// Gemini Datasource
/// Handles all interactions with Google Gemini API for AI recipe generation
abstract class GeminiDatasource {
  /// Generate a recipe based on user inputs
  Future<Map<String, dynamic>> generateRecipe({
    required List<String> ingredients,
    String? mealType,
    String? dietaryGoal,
    int? servings,
    int? timeConstraint,
  });

  /// Get Sunnah alternative for a given ingredient
  Future<String> getSunnahAlternative(String ingredient);

  /// Validate if ingredients are Sunnah-compliant
  Future<Map<String, bool>> validateSunnahIngredients(List<String> ingredients);
}

class GeminiDatasourceImpl implements GeminiDatasource {
  final GenerativeModel _model;

  GeminiDatasourceImpl({GenerativeModel? model})
      : _model = model ??
            GenerativeModel(
              model: GeminiConfig.model,
              apiKey: GeminiConfig.apiKey,
              generationConfig: GenerationConfig(
                temperature: GeminiConfig.temperature,
                maxOutputTokens: GeminiConfig.maxOutputTokens,
              ),
              systemInstruction:
                  Content.system(GeminiConfig.recipeSystemPrompt),
            );

  @override
  Future<Map<String, dynamic>> generateRecipe({
    required List<String> ingredients,
    String? mealType,
    String? dietaryGoal,
    int? servings,
    int? timeConstraint,
  }) async {
    try {
      Logger.i('Generating recipe with Gemini');
      Logger.d('Ingredients: $ingredients');

      final userPrompt = _buildRecipePrompt(
        ingredients: ingredients,
        mealType: mealType,
        dietaryGoal: dietaryGoal,
        servings: servings,
        timeConstraint: timeConstraint,
      );

      final content = [Content.text(userPrompt)];
      final response = await _model.generateContent(content);

      if (response.text != null) {
        Logger.i('Recipe generated successfully');
        return _parseRecipeResponse(response.text!);
      } else {
        throw const AIException(message: 'Empty response from Gemini');
      }
    } catch (e) {
      if (e is AIException) rethrow;
      Logger.e('Error generating recipe with Gemini: $e');
      throw AIException(message: 'Failed to generate recipe: ${e.toString()}');
    }
  }

  @override
  Future<String> getSunnahAlternative(String ingredient) async {
    try {
      Logger.i('Getting Sunnah alternative for: $ingredient');

      // For a specific instruction like alternatives, we might want a simpler model or different system prompt
      // But for consistency we can use the same model with a targeted prompt if needed.
      // Or create a separate model instance with a different system prompt.

      final alternativeModel = GenerativeModel(
        model: GeminiConfig.model,
        apiKey: GeminiConfig.apiKey,
        systemInstruction: Content.system(GeminiConfig.alternativeSystemPrompt),
      );

      final content = [
        Content.text(
            'What is a good Sunnah alternative for: $ingredient? Be brief and practical.')
      ];
      final response = await alternativeModel.generateContent(content);

      if (response.text != null) {
        return response.text!.trim();
      } else {
        throw const AIException(message: 'Empty response from Gemini');
      }
    } catch (e) {
      Logger.e('Error getting Sunnah alternative with Gemini: $e');
      throw AIException(message: 'Failed to get alternative: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, bool>> validateSunnahIngredients(
      List<String> ingredients) async {
    // List of known Sunnah ingredients
    final sunnahIngredients = [
      'dates',
      'ajwa',
      'honey',
      'black seed',
      'nigella',
      'olive oil',
      'olives',
      'barley',
      'milk',
      'vinegar',
      'watermelon',
      'pumpkin',
      'gourd',
      'lamb',
      'mutton',
      'figs',
      'grapes',
      'raisins',
      'pomegranate',
      'cucumber',
    ];

    final result = <String, bool>{};

    for (final ingredient in ingredients) {
      final lowerIngredient = ingredient.toLowerCase();
      final isSunnah = sunnahIngredients.any(
        (sunnah) => lowerIngredient.contains(sunnah),
      );
      result[ingredient] = isSunnah;
    }

    Logger.i('Validated ${ingredients.length} ingredients');
    Logger.d('Validation result: $result');

    return result;
  }

  String _buildRecipePrompt({
    required List<String> ingredients,
    String? mealType,
    String? dietaryGoal,
    int? servings,
    int? timeConstraint,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('Create a delicious Sunnah recipe using these ingredients:');
    buffer.writeln(ingredients.join(', '));
    buffer.writeln();

    if (mealType != null) {
      buffer.writeln('Meal Type: $mealType');
    }

    if (dietaryGoal != null) {
      buffer.writeln('Dietary Goal: $dietaryGoal');
    }

    if (servings != null) {
      buffer.writeln('Servings: $servings');
    }

    if (timeConstraint != null) {
      buffer.writeln('Time Constraint: Maximum $timeConstraint minutes');
    }

    buffer.writeln();
    buffer.writeln(
        'Please provide the recipe in the exact JSON format specified.');
    buffer.writeln('Ensure all ingredients used are Sunnah-approved.');

    return buffer.toString();
  }

  Map<String, dynamic> _parseRecipeResponse(String content) {
    try {
      String jsonContent = content.trim();

      // Remove markdown code blocks if present
      if (jsonContent.startsWith('```json')) {
        jsonContent = jsonContent.substring(7);
      } else if (jsonContent.startsWith('```')) {
        jsonContent = jsonContent.substring(3);
      }

      if (jsonContent.endsWith('```')) {
        jsonContent = jsonContent.substring(0, jsonContent.length - 3);
      }

      jsonContent = jsonContent.trim();
      return jsonDecode(jsonContent) as Map<String, dynamic>;
    } catch (e) {
      Logger.e('Error parsing Gemini response: $e');
      throw AIException(
          message: 'Failed to parse recipe response: ${e.toString()}');
    }
  }
}
