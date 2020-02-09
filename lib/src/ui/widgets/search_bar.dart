import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/meals_screen_provider.dart';
import '../global/style_list.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MealsScreenProvider mealsScreenProvider =
        Provider.of<MealsScreenProvider>(context, listen: false);
    return TextField(
      onChanged: mealsScreenProvider.searchInput,
      controller: mealsScreenProvider.searchController,
      decoration: InputDecoration(
        contentPadding: StyleList.horizontalPadding20,
        hintText: 'Meal Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
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
                  color: Theme.of(context).accentColor,
                ),
              ),
      ),
    );
  }
}
