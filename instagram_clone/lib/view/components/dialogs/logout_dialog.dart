import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/view/components/constants/strings.dart';

// import '../constants/strings.dart';
import 'alert_dialog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  LogoutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}
