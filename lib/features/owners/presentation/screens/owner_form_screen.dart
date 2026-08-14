import 'package:fishing_app/core/constants/app_gap.dart';
import 'package:fishing_app/core/constants/app_spacing.dart';
import 'package:fishing_app/features/owners/data/models/owner_model.dart';
import 'package:fishing_app/features/owners/presentation/providers/owner_provider.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OwnerFormScreen extends ConsumerStatefulWidget {
  final OwnerModel? owner;
  const OwnerFormScreen({super.key, this.owner});

  @override
  ConsumerState<OwnerFormScreen> createState() => _OwnerFormScreenState();
}

class _OwnerFormScreenState extends ConsumerState<OwnerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.owner?.name ?? "");
    phoneController = TextEditingController(text: widget.owner?.phone ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.owner == null ? l10n!.addOwner : l10n!.editOwner),
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
                    return l10n.enterOwnerName;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(l10n.name),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              AppGap.h12,

              // Phone
              TextFormField(
                controller: phoneController,

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("${l10n.phone}*"),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              AppGap.h16,
              ElevatedButton(
                onPressed: ref.read(ownerProvider).isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        final messanger = ScaffoldMessenger.of(context);
                        final focusScope = FocusScope.of(context);
                        final router = GoRouter.of(context);

                        if (widget.owner == null) {
                          await ref
                              .read(ownerProvider.notifier)
                              .addOwner(
                                OwnerModel(
                                  name: nameController.text.trim(),
                                  phone: phoneController.text.trim().isEmpty
                                      ? null
                                      : phoneController.text.trim(),
                                ),
                              );
                        } else {
                          await ref
                              .read(ownerProvider.notifier)
                              .updateOwner(
                                OwnerModel(
                                  id: widget.owner!.id,
                                  name: nameController.text.trim(),
                                  phone: phoneController.text.trim().isEmpty
                                      ? null
                                      : phoneController.text.trim(),
                                ),
                              );
                        }

                        if (ref.read(ownerProvider).errorMessage != null) {
                          messanger.showSnackBar(
                            SnackBar(
                              content: Text(
                                "${l10n.error}: ${l10n.failedToSave} \n ${ref.read(ownerProvider).errorMessage}",
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
                child: Text(widget.owner == null ? l10n.save : l10n.update),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
