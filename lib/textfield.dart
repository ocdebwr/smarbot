import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;
    final iconColor = isFocused ? Theme.of(context).colorScheme.secondary : Colors.grey[500];

    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      focusNode: _focusNode,
      onTap: widget.onTap,
      textInputAction: TextInputAction.next,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon != null
            ? IconTheme(
                data: IconThemeData(color: iconColor),
                child: widget.suffixIcon!,
              )
            : null,
        prefixIcon: widget.prefixIcon != null
            ? IconTheme(
                data: IconThemeData(color: iconColor),
                child: widget.prefixIcon!,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        errorText: widget.errorMsg,
      ),
    );
  }
}
