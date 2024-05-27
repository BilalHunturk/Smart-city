import 'package:bocekilaclama/export.dart';
import 'package:bocekilaclama/views/widgets/custom_app_bar.dart';
import 'package:flutter/services.dart';

class CommentView extends StatelessWidget {
  const CommentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Comment"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: ColorConstants.secondary,
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(16.0.h),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                          color: ColorConstants.whiteColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: TextFormField(
                        style: UiHelper.headline1,
                        decoration: InputDecoration(hintText: "Name"),
                        textCapitalization: TextCapitalization.sentences,
                      )),
                  UiHelper.defaultSpaceHeight,
                  Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                          color: ColorConstants.whiteColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: TextField(
                        decoration: InputDecoration(hintText: "Description"),
                        style: UiHelper.headline1,
                        maxLengthEnforcement:
                            MaxLengthEnforcement.truncateAfterCompositionEnds,
                        maxLength: 500,
                        maxLines: 3,
                      )),
                  UiHelper.defaultSpaceHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        items: [
                          DropdownMenuItem(
                            value: 'value1',
                            child: UiHelper.appText("Suggestion",
                                color: ColorConstants.whiteColor),
                          ),
                          DropdownMenuItem(
                            value: 'value2',
                            child: UiHelper.appText("Complaint",
                                color: ColorConstants.whiteColor),
                          )
                        ],
                        value: "value1",
                        onChanged: (value) {},
                      ),
                      TextButton(
                        child: UiHelper.appText("Send",
                            color: ColorConstants.whiteColor),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
