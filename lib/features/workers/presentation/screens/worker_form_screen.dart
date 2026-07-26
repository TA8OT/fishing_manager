import 'package:fishing_app/core/constants/app_gap.dart';
import 'package:fishing_app/core/constants/app_spacing.dart';
import 'package:fishing_app/features/workers/data/models/worker_model.dart';
import 'package:fishing_app/features/workers/presentation/providers/worker_provider.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WorkerFormScreen extends ConsumerStatefulWidget {
  final WorkerModel? worker;
  const WorkerFormScreen({super.key, this.worker});

  @override
  ConsumerState<WorkerFormScreen> createState() => _WorkerFormScreenState();
}

class _WorkerFormScreenState extends ConsumerState<WorkerFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.worker?.name ?? "");
    phoneController = TextEditingController(text: widget.worker?.phone ?? "");
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
        title: Text(widget.worker == null ? l10n!.addWorker : l10n!.editWorker),
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
                    return l10n.enterWorkerName;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(l10n.workerName),
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
                onPressed: ref.read(workerProvider).isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        final messanger = ScaffoldMessenger.of(context);
                        final focusScope = FocusScope.of(context);
                        final router = GoRouter.of(context);

                        if (widget.worker == null) {
                          await ref
                              .read(workerProvider.notifier)
                              .addWorker(
                                WorkerModel(
                                  name: nameController.text.trim(),
                                  phone: phoneController.text.trim().isEmpty
                                      ? null
                                      : phoneController.text.trim(),
                                ),
                              );
                        } else {
                          await ref
                              .read(workerProvider.notifier)
                              .updateWorker(
                                WorkerModel(
                                  id: widget.worker!.id,
                                  name: nameController.text.trim(),
                                  phone: phoneController.text.trim(),
                                ),
                              );
                        }

                        if (ref.read(workerProvider).errorMessage != null) {
                          messanger.showSnackBar(
                            SnackBar(
                              content: Text(
                                "${l10n.error}: ${l10n.failedToSave} \n ${ref.read(workerProvider).errorMessage}",
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
                child: Text(widget.worker == null ? l10n.save : l10n.update),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
