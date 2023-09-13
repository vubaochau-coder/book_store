import 'package:book_store/screens/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNoteTextField extends StatelessWidget {
  final TextEditingController textController;
  const UserNoteTextField({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      buildWhen: (previous, current) {
        return previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const SizedBox();
        }

        return Container(
          height: 48,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          color: Colors.white,
          child: Row(
            children: [
              const Text('Tin nhắn:'),
              Expanded(
                child: TextField(
                  controller: textController,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Tin nhắn cho người bán...',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
