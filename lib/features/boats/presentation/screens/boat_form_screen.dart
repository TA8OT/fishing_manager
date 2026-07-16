import 'package:fishing_app/core/constants/app_gap.dart';
import 'package:fishing_app/core/constants/app_sizes.dart';
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
  final nameController = TextEditingController();
  final registrationController = TextEditingController();
  final captainController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.boat != null) {
      nameController.text = widget.boat!.name;
      registrationController.text = widget.boat!.registrationNumber;
      captainController.text = widget.boat!.captainShare.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    registrationController.dispose();
    captainController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(boatProvider);

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
                controller: captainController,
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

                onPressed: state.isLoading
                    ? null
                    : () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        final boat = BoatModel(
                          name: nameController.text,
                          registrationNumber: registrationController.text,
                          captainShare: double.parse(captainController.text),
                        );

                        ref.read(boatProvider.notifier).addBoat(boat);

                        if (state.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "${l10n.error}: ${l10n.failedToSave}  \n ${state.errorMessage}",
                              ),
                            ),
                          );
                          return;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.succeeded)),
                          );
                          FocusScope.of(context).unfocus();
                          context.pop();
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
