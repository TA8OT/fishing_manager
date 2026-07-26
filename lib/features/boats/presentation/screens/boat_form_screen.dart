import 'package:fishing_app/core/constants/app_gap.dart';
import 'package:fishing_app/core/constants/app_spacing.dart';
import 'package:fishing_app/features/boats/data/models/boat_model.dart';
import 'package:fishing_app/features/boats/presentation/providers/boat_provider.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BoatFormScreen extends ConsumerStatefulWidget {
  final BoatModel? boat;
  const BoatFormScreen({super.key, this.boat});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BoatFormScreenState();
}

class _BoatFormScreenState extends ConsumerState<BoatFormScreen> {
  late final TextEditingController nameController;
  late final TextEditingController registrationController;
  late final TextEditingController captainShareController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.boat?.name ?? '');

    registrationController = TextEditingController(
      text: widget.boat?.registrationNumber ?? '',
    );

    captainShareController = TextEditingController(
      text: widget.boat?.captainShare.toString() ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    registrationController.dispose();
    captainShareController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boat == null ? l10n!.addBoat : l10n!.editBoat),
      ),
      body: Form(
        key: _formKey,

        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              // Name
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.enterBoatName;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(l10n.boatName),
                  prefixIcon: Icon(Icons.directions_boat),
                ),
              ),
              AppGap.h12,

              // Registration Number
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.enterRegistrationNumber;
                  }
                  return null;
                },
                controller: registrationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(l10n.registrationNumber),
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
              AppGap.h12,

              // Captain Share
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.enterCaptainShare;
                  }
                  double? share = double.tryParse(value);
                  if (share == null || share.isNaN) {
                    return l10n.enterValidCaptainShare;
                  }
                  if (share.isNegative) {
                    return l10n.enterPositiveNumber;
                  }
                  if (share > 100 || share < 0) {
                    return l10n.enterValidCaptainShare;
                  }

                  return null;
                },
                controller: captainShareController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(l10n.captainShare),
                  prefixIcon: Icon(Icons.handshake),
                ),
              ),
              AppGap.h16,
              ElevatedButton(
                style: ButtonStyle(),

                onPressed: ref.read(boatProvider).isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        final messenger = ScaffoldMessenger.of(context);
                        final focusScope = FocusScope.of(context);
                        final router = GoRouter.of(context);

                        if (widget.boat == null) {
                          await ref
                              .read(boatProvider.notifier)
                              .addBoat(
                                BoatModel(
                                  name: nameController.text.trim(),
                                  registrationNumber: registrationController
                                      .text
                                      .trim(),
                                  captainShare: double.parse(
                                    captainShareController.text.trim(),
                                  ),
                                ),
                              );
                        } else {
                          await ref
                              .read(boatProvider.notifier)
                              .updateBoat(
                                BoatModel(
                                  id: widget.boat!.id,
                                  name: nameController.text.trim(),
                                  registrationNumber: registrationController
                                      .text
                                      .trim(),
                                  captainShare: double.parse(
                                    captainShareController.text.trim(),
                                  ),
                                ),
                              );
                        }

                        if (ref.read(boatProvider).errorMessage != null) {
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text(
                                "${l10n.error}: ${l10n.failedToSave}  \n ${ref.read(boatProvider).errorMessage}",
                              ),
                            ),
                          );
                          return;
                        } else {
                          messenger.showSnackBar(
                            SnackBar(content: Text(l10n.succeeded)),
                          );

                          focusScope.unfocus();
                          router.pop();
                        }
                      },
                child: Text(widget.boat == null ? l10n.save : l10n.update),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
