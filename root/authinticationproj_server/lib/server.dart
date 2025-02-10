import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:serverpod/serverpod.dart';

import 'package:authinticationproj_server/src/web/routes/root.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';
import 'src/endpoints/openai_endpoint.dart'; // Import the OpenAI endpoint

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  // Get API key from secure config
  final openaiApiKey = pod.config.get('openai_api_key') ?? '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';
  if (openaiApiKey.isEmpty) {
    throw Exception('Add OpenAI key to config/config.yaml');
  }

  // Add the root route to the web server
  pod.webServer.addRoute(RouteRoot() ,'/');
    
   // Configuration for sign in with email.
auth.AuthConfig.set(auth.AuthConfig(
  sendValidationEmail: (session, email, validationCode) async {
    // Retrieve the credentials
    final gmailEmail = session.serverpod.getPassword('gmailEmail')!;
    final gmailPassword = session.serverpod.getPassword('gmailPassword')!;

    // Create a SMTP client for Gmail.
    final smtpServer = gmail(gmailEmail, gmailPassword);

    // Create an email message with the validation code.
    final message = Message()
      ..from = Address(gmailEmail)
      ..recipients.add(email)
      ..subject = 'Verification code for Serverpod'
      ..html = 'Your verification code is: $validationCode';

    // Send the email message.
    try {
      await send(message, smtpServer);
    } catch (_) {
      // Return false if the email could not be sent.
      return false;
    }

    return true;
  },
  sendPasswordResetEmail: (session, userInfo, validationCode) async {
    // Retrieve the credentials
    final gmailEmail = session.serverpod.getPassword('gmailEmail')!;
    final gmailPassword = session.serverpod.getPassword('gmailPassword')!;

    // Create a SMTP client for Gmail.
    final smtpServer = gmail(gmailEmail, gmailPassword);

    // Create an email message with the password reset link.
    final message = Message()
      ..from = Address(gmailEmail)
      ..recipients.add(userInfo.email!)
      ..subject = 'Password reset link for Serverpod'
      ..html = 'Here is your password reset code: $validationCode';

    // Send the email message.
    try {
      await send(message, smtpServer);
    } catch (_) {
      // Return false if the email could not be sent.
      return false;
    }

    return true;
  },
  ));

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  // Start the server.
  await pod.start();
}

extension on ServerpodConfig {
  get(String s) {}
}