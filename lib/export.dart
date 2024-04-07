// widgets
export 'package:dartz/dartz.dart' hide State, Order, Task;
export 'package:flutter/material.dart' hide TextDirection;
export 'package:flutter/services.dart' hide TextInput, TextDirection;
export 'package:flutter_bloc/flutter_bloc.dart';
// most used packages
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:go_router/go_router.dart';
export 'package:logger/logger.dart';
export 'package:tasks/core/app_router.dart';
export 'package:tasks/core/base_state.dart';

export 'core/app_colors.dart';
export 'core/constants.dart';
export 'core/error/failures.dart';
export 'core/injection_container.dart';
// models

export 'core/network/server_response.dart';
// constants
export 'core/theme.dart';
export 'core/extensions/num_extension.dart';
export 'package:tasks/assets.dart';
export 'core/view/widgets/custom_app_bar.dart';
export 'core/view/widgets/rounded_corner_button.dart';
export 'core/view/widgets/text_input.dart';
export 'core/view/widgets/action_icon.dart';
export 'generated/translations.g.dart';
export 'package:easy_localization/easy_localization.dart';
export 'package:tasks/core/view/widgets/rounded_corner_loading_button.dart';
