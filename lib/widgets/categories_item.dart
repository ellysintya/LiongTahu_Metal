
import 'package:flutter/material.dart';
import 'package:butter_app_project/const.dart';
import 'package:butter_app_project/model/categories_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
    required this.selected,
  }) : super(key: key);

  final CategoriesModel category;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? red.withOpacity(0.3) : grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          selected
              ? const BoxShadow(
                  color: red,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(2, 3))
              : const BoxShadow(color: transparent),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16), 
          Text(
            category.name,
            style: poppins.copyWith(
              color: selected ? white : black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
