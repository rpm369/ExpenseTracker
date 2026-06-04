import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:flutter/widgets.dart';

class PrivacyPolicySheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 15,
        children: [
          FormHeader(title: "Privacy Policy"),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                data,
                style: TextStyle(
                  fontSize: 20,
                  wordSpacing: 2,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String data =
      '''Lorem ipsum m/ LOR-əm IP-səm) is a dummy or placeholder text commonly used in graphic design, publishing, and web development. It is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.[not in body] The first two words are the truncation of dolorem ipsum ("pain itself"). Lorem ipsum's purpose is to permit a page layout to be designed, independently of the copy that will subsequently populate it, or to demonstrate various fonts of a typeface without meaningful text that could be distracting.

Versions of the Lorem ipsum text have been used in typesetting since the late 1960s, when Letraset transfer sheets containing the placeholder text popularized it.[1] Lorem ipsum was introduced to the digital world in the mid-1980s, when Aldus employed it in graphic and word-processing templates for its desktop publishing program PageMaker.[not in body] Other popular word processors, including Pages and Microsoft Word, have since adopted Lorem ipsum,[2] as have many LaTeX packages,[3][4][5] web content managers such as Joomla! and WordPress, and CSS libraries such as Semantic UI.[not in body]''';
}
