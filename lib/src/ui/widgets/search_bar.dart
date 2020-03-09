import 'package:flutter/material.dart';
import '../../core/providers/meals_screen_provider.dart';
import '../global/extensions.dart';
import '../global/style_list.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MealsScreenProvider mealsScreenProvider =
        context.provider<MealsScreenProvider>();
    return TextField(
      onChanged: mealsScreenProvider.searchInput,
      controller: mealsScreenProvider.searchController,
      decoration: InputDecoration(
        contentPadding: StyleList.horizontalPadding20,
        // hintText: context.translate('searchHint'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: context.accentColor,
          ),
        ),
        suffixIcon: mealsScreenProvider.toggleIcon()
            ? Icon(
                Icons.search,
              )
            : IconButton(
                onPressed: mealsScreenProvider.clearKeywords,
                icon: Icon(
                  Icons.clear,
                  color: context.accentColor,
                ),
              ),
      ),
    );
  }
}
