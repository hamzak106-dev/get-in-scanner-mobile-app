import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_theme.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_util.dart';
import 'package:g_e_t_i_n_scanner/flutter_flow/flutter_flow_widgets.dart';

import '../../custom_code/actions/index.dart';
import '../../index.dart';
import '../../pages/home_screens/scanner_pos/feature_not_available.dart';

class AmountEntryWidget extends StatefulWidget {
  final void Function()? onContinue;
  final String eventId;

  const AmountEntryWidget({super.key, required this.eventId, this.onContinue});

  @override
  State<AmountEntryWidget> createState() => _AmountEntryWidgetState();
}

class _AmountEntryWidgetState extends State<AmountEntryWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool isInitialized = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = NoKeyboardFocusNode();

    QuickPay().initTerminal(int.parse(widget.eventId), onInitialized: () {
      setState(() => isInitialized = true);
    }, onError: (err) {
      context.pushNamed(FeatureDisabledPage.routeName, pathParameters: {
        'message': '$err',
      });
    });
  }

  String? userText;

  void addNumber(String value) {
    if ((userText == null || userText!.isEmpty) &&
        (value == '0' || value == '.')) {
      return;
    }

    if (value == '.' && userText?.contains('.') == true) {
      return;
    }

    final newText = (userText ?? '') + value;

    if (newText.length > 9) {
      setState(() {
        errorMessage = "Maximum 9 digits allowed";
      });
      return;
    }

    userText = newText;
    manageController();
    _focusNode.requestFocus();
    if (errorMessage != null) {
      errorMessage = null;
    }
    setState(() {});
  }

  void manageController() {
    if (userText == null || userText!.isEmpty) {
      _controller.text = '';
      _controller.selection =
          TextSelection.fromPosition(TextPosition(offset: 0));
      return;
    }

    if (userText?.contains('.') == true) {
      final parts = userText!.split('.');
      if (parts.length > 1 && parts[1].length > 2) {
        _controller.text = parts[0] + '.' + parts[1].substring(0, 2);
      } else if (parts[1].length == 0) {
        _controller.text = userText! + '00';
      } else if (parts[1].length == 1) {
        _controller.text = userText! + '0';
      } else {
        _controller.text = userText!;
      }
    } else {
      _controller.text = userText! + '.00';
    }
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: userText?.length ?? 0));
  }

  void _backspace() {
    if (userText == null || userText!.isEmpty) {
      _focusNode.unfocus();
      return;
    }

    userText = userText!.substring(0, userText!.length - 1);
    manageController();

    if ((userText?.length ?? 0) <= 9) {
      setState(() => errorMessage = null);
    }

    if (userText == null || userText!.isEmpty) {
      errorMessage = null;
      _focusNode.unfocus();
    }
  }

  double _parsedAmount() {
    final t = _controller.text;
    if (t.isEmpty || t == ".") return 0.0;
    return double.tryParse(t) ?? 0.0;
  }

  Future<void> _handleContinue() async {
    final amount = _parsedAmount();
    if (amount < 1) {
      setState(() => errorMessage = "Please enter an amount greater than 1");
      return;
    }

    await QuickPay().start(
      amount: amount.toString(),
      eventId: widget.eventId.toString(),
      onSuccess: () {
        // appNavigatorKey.currentContext?.safePop();
        appNavigatorKey.currentContext?.pushNamed(
          EventPagePurchaserDetailsWidget.routeName,
          pathParameters: {
            'event_id': serializeParam(widget.eventId, ParamType.int)!,
            'hash': serializeParam(
                QuickPay().tapToPayResponse?.data.hash, ParamType.String)!,
          },
        );
        widget.onContinue?.call();
      },
      onError: (msg) {
        // appNavigatorKey.currentContext?.safePop();
        appNavigatorKey.currentContext
            ?.pushNamed(FeatureDisabledPage.routeName, pathParameters: {
          'message': '$msg',
        });
        widget.onContinue?.call();
      },
      onCancel: () {
        // appNavigatorKey.currentContext?.safePop();
        widget.onContinue?.call();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final amount = _parsedAmount();
    print("isInitialized ::: $isInitialized");

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // textBaseline: TextBaseline.ideographic,
                        children: [
                          const Text(
                            "\$",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: GestureDetector(
                              onTapDown: (details) {
                                final box =
                                    context.findRenderObject() as RenderBox?;
                                if (box != null) {
                                  final local =
                                      box.globalToLocal(details.globalPosition);
                                  final position = _controller.text.length;
                                  _controller.selection =
                                      TextSelection.fromPosition(
                                    TextPosition(offset: position),
                                  );
                                }
                                FocusScope.of(context).requestFocus(_focusNode);
                              },
                              child: AbsorbPointer(
                                absorbing: false,
                                child: TextField(
                                  controller: _controller,
                                  focusNode: _focusNode,
                                  readOnly: true,
                                  showCursor: true,
                                  enableInteractiveSelection: true,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    hintText: "0.00",
                                    hintStyle: TextStyle(
                                      color: Colors.white.withValues(alpha: .8),
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Custom Keypad
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.8,
                  mainAxisSpacing: 12,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return TextButton(
                      onPressed: () => addNumber("."),
                      child: const Text(".",
                          style: TextStyle(color: Colors.white, fontSize: 28)),
                    );
                  } else if (index == 11) {
                    return IconButton(
                      onPressed: _backspace,
                      icon: SvgPicture.asset(
                        'assets/svg/keyboard_back_icon.svg',
                        color: Colors.white,
                        width: 24,
                        height: 24,
                      ),
                    );
                  } else {
                    int digit = (index == 10) ? 0 : index + 1;
                    return TextButton(
                      onPressed: () => addNumber(digit.toString()),
                      child: Text("$digit",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 28)),
                    );
                  }
                },
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: FFButtonWidget(
                    text: isiOS ? "Tap to Pay on iPhone" : "CONTINUE",
                    onPressed: (amount >= 1 && isInitialized)
                        ? () async => await _handleContinue()
                        : null,
                    showLoadingIndicator: true,
                    options: FFButtonOptions(
                      height: 40.0,
                      color: amount >= 1 ? Colors.white : Colors.black,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily: 'Mona Sans',
                            color: amount >= 1
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : FlutterFlowTheme.of(context).primaryText,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                          ),
                      elevation: 0.0,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
        if (!isInitialized)
          CircularProgressIndicator(
            color: Colors.white,
          )
      ],
    );
  }

  @override
  void dispose() {
    QuickPay().dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
