import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/theme/app_spacing.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';

/// Search Screen
/// Global search for ingredients and recipes
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search ingredients or recipes...',
            hintStyle: AppTypography.body2.copyWith(
              color: AppColors.textTertiary,
            ),
            border: InputBorder.none,
          ),
          style: AppTypography.body1.copyWith(
            color: AppColors.textPrimary,
          ),
          onChanged: (value) {
            setState(() => _searchQuery = value);
          },
        ),
        actions: [
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: AppColors.textPrimary),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
            ),
        ],
      ),
      body:
          _searchQuery.isEmpty ? _buildRecentSearches() : _buildSearchResults(),
    );
  }

  Widget _buildRecentSearches() {
    final recentSearches = ['Dates', 'Honey', 'Talbina'];

    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Searches',
            style: AppTypography.h3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          ...recentSearches.map((search) => ListTile(
                leading:
                    const Icon(Icons.history, color: AppColors.textTertiary),
                title: Text(
                  search,
                  style: AppTypography.body1.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  color: AppColors.textTertiary,
                  onPressed: () {
                    // TODO: Remove from recent searches
                  },
                ),
                onTap: () {
                  setState(() {
                    _searchController.text = search;
                    _searchQuery = search;
                  });
                },
              )),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    // TODO: Get actual search results from controller
    final ingredients = [
      {'name': 'Dates (Ajwa)', 'type': 'Ingredient'},
      {'name': 'Honey', 'type': 'Ingredient'},
    ];

    final recipes = [
      {'name': 'Date Smoothie', 'type': 'Recipe'},
      {'name': 'Honey & Black Seed Mix', 'type': 'Recipe'},
    ];

    return ListView(
      padding: EdgeInsets.all(AppSpacing.md),
      children: [
        if (ingredients.isNotEmpty) ...[
          Text(
            'Ingredients',
            style: AppTypography.h3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          ...ingredients.map((item) => _buildResultItem(item)),
          SizedBox(height: AppSpacing.lg),
        ],
        if (recipes.isNotEmpty) ...[
          Text(
            'Recipes',
            style: AppTypography.h3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          ...recipes.map((item) => _buildResultItem(item)),
        ],
      ],
    );
  }

  Widget _buildResultItem(Map<String, String> item) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          item['type'] == 'Ingredient' ? Icons.eco : Icons.restaurant,
          color: AppColors.primary,
        ),
        title: Text(
          item['name']!,
          style: AppTypography.body1.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          item['type']!,
          style: AppTypography.caption.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.textTertiary,
        ),
        onTap: () {
          // TODO: Navigate to detail screen
        },
      ),
    );
  }
}
