import 'package:fishing_app/core/constants/app_gap.dart';
import 'package:fishing_app/core/constants/app_spacing.dart';
import 'package:fishing_app/features/fishs/data/models/fish_model.dart';
import 'package:fishing_app/features/fishs/presentation/providers/fish_provider.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FishFormScreen extends ConsumerStatefulWidget {
  final FishModel? fish;
  const FishFormScreen({super.key, this.fish});

  @override
  ConsumerState<FishFormScreen> createState() => _FishFormScreenState();
}

class _FishFormScreenState extends ConsumerState<FishFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.fish?.name ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fish == null ? l10n!.addFish : l10n!.editFish),
      ),
      body: Form(
        key: _formKey,

        child: Padding(
          padding: EdgeInsetsGeometry.all(AppSpacing.md),
          child: Column(
            // Name
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.enterFishName;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(l10n.name),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              AppGap.h16,
              ElevatedButton(
                onPressed: ref.read(fishProvider).isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        final messanger = ScaffoldMessenger.of(context);
                        final focusScope = FocusScope.of(context);
                        final router = GoRouter.of(context);

                        if (widget.fish == null) {
                          await ref
                              .read(fishProvider.notifier)
                              .addFish(
                                FishModel(name: nameController.text.trim()),
                              );
                        } else {
                          await ref
                              .read(fishProvider.notifier)
                              .updateFish(
                                FishModel(
                                  id: widget.fish!.id,
                                  name: nameController.text.trim(),
                                ),
                              );
                        }

                        if (ref.read(fishProvider).errorMessage != null) {
                          messanger.showSnackBar(
                            SnackBar(
                              content: Text(
                                "${l10n.error}: ${l10n.failedToSave} \n ${ref.read(fishProvider).errorMessage}",
                              ),
                            ),
                          );
                          return;
                        } else {
                          messanger.showSnackBar(
                            SnackBar(content: Text(l10n.succeeded)),
                          );

                          focusScope.unfocus();
                          router.pop();
                        }
                      },
                child: Text(widget.fish == null ? l10n.save : l10n.update),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
