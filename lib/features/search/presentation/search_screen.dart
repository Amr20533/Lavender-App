import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/search/presentation/cubit/search_cubit.dart';
import 'package:lavender/features/search/presentation/cubit/search_states.dart';

import '../../home/presenation/widgets/doctor_card.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final text = _searchController.text.trim();
      context.read<SearchCubit>().search(text);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.h, left: 16, right: 16),
        child: Column(
          children: [
            SearchAnchor(
              isFullScreen: false,
              viewHintText: "Search doctors",
              builder: (context, controller) {
                return TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search doctors",
                    prefixIcon: GestureDetector(
                      onTap: () {
                        context.read<SearchCubit>().clear();
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: AppColors.primaryColorLavenderLangAndText,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.primaryColorLavenderLangAndText,
                      ),
                    ),
                  ),
                );
              },
              suggestionsBuilder: (context, _) {
                return [];
              },
            ),

            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const SizedBox.shrink();
                  } else if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    return ListView.separated(
                      itemCount: state.specialists.length,
                      separatorBuilder: (context, _) => SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final doc = state.specialists[index];
                        return DoctorCard(
                          specialist: doc,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.psychologistDetailsPage,
                              arguments: doc,
                            );
                          },
                        );
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text("Error: ${state.message}"));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
