import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/data/model/sections.dart';
import 'package:ecotyper/features/gameplay/ui/pages/select_level_page.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/sections_grid_tile.dart';

class SelectSectionBody extends StatelessWidget {
  const SelectSectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.sp,
        mainAxisSpacing: 12.sp,
      ),
      children: Sections.values
          .map(
            (section) => SectionsGridTile(
              title: section.title,
              onTap: () {
                // save value to bloc
                var bloc = context.read<GameplayBloc>();
                bloc.setSelectedSection(section);
                // show level selection dialog
                Navigator.push(
                  context,
                  SelectLevelPage.route(),
                );
                // showDialog(
                //   context: context,
                //   builder: (context) {

                //     // return UI
                //     return const SelectLevelDialog();
                //   },
                // );
              },
            ),
          )
          .toList(),
    );
  }
}
