import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/providers/app_provider.dart';

List<SingleChildWidget> providers = [
  ...independentProviders,
  ...dependentProviders,
  ...uiProviders,
];

List<SingleChildWidget> independentProviders = [
  Provider(
    create: (_) => AppProvider(),
    dispose: (_, appProvider) => appProvider.dispose,
  ),
];

List<SingleChildWidget> dependentProviders = [];

List<SingleChildWidget> uiProviders = [];
