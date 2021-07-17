const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp();

/**
 * Triggers when a user gets a new follower and sends a notification.
 *
 * Followers add a flag to `/followers/{followedUid}/{followerUid}`.
 * Users save their device notification tokens to
 * `/users/{followedUid}/notificationTokens/{notificationToken}`.
 */
exports.sendCompleteNotification =
    functions.firestore.document("/Orders/{orderId}")
        .onUpdate(async (change, context) => {
          const newValue = change.after.get("Done");
          const previousValue = change.before.get("Done");

          const orderDone = newValue !== previousValue;
          if (! orderDone) {
            return functions.logger.log({orderDone});
          }
          const orderId = context.params.orderId;
          const fromId = change.after.get("From");

          functions.logger.log(
              "We have a new completed order:",
              orderId,
              "placed by:",
              fromId,
          );

          // Get the list of device notification tokens.
          const getUserPromise = admin.firestore().collection("User").doc(fromId).get();

          const results = await Promise.all([getUserPromise]);
          const userSnapshot = results[0];
          const tokenList = userSnapshot.get("Tokens");

          // Check if there are any device tokens.
          if (tokenList.isEmpty) {
            return functions.logger.log(
                "There are no notification tokens to send to.",
            );
          }
          functions.logger.log(
              "There are",
              tokenList.length,
              "tokens to send notifications to.",
          );

          // Notification details.
          const payload = {
            notification: {
              title: `Your order (Order no. ${orderId}) has arrived!`,
              body: "Please verify your order.",
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              screen: "myOrders",
              args: orderId,
            },
          };
          // Send notifications to all tokens.
          const response = await admin.messaging().sendToDevice(tokenList, payload);
          // For each message check if there was an error.
          const tokensToRemove = [];
          response.results.forEach((result, index) => {
            const error = result.error;
            if (error) {
              functions.logger.error(
                  "Failure sending notification to",
                  tokenList[index],
                  error,
              );
              // Cleanup the tokens who are not registered anymore.
              if (error.code === "messaging/invalid-registration-token" ||
                  error.code === "messaging/registration-token-not-registered") {
                tokensToRemove.push(userSnapshot.ref.update("Tokens", tokenList.splice(index, 1)));
              }
            }
          });
          return Promise.all(tokensToRemove);
        });

exports.sendChatNotification =
    functions.firestore.document("/Messages/{recipientId}/Contacts/{contactId}/Texts/{messageId}")
        .onCreate(async (change, context) => {
          const message = change.get("Message");
          const recipientId = context.params.recipientId;
          const contactId = context.params.contactId;

          functions.logger.log(
              "New message sent from",
              contactId,
              "to",
              recipientId,
          );

          // Get the list of device notification tokens.
          const getContactPromise = admin.firestore().collection("User").doc(contactId).get();
          const getRecipientPromise = admin.firestore().collection("User").doc(recipientId).get();

          const results = await Promise.all([getContactPromise, getRecipientPromise]);
          const contactSnapshot = results[0];
          const recipientSnapshot = results[1];
          const tokenList = recipientSnapshot.get("Tokens");
          const contactName = contactSnapshot.get("Username");

          // Check if there are any device tokens.
          if (tokenList.isEmpty) {
            return functions.logger.log(
                "There are no notification tokens to send to.",
            );
          }

          functions.logger.log(
              "There are",
              tokenList.length,
              "tokens to send notifications to.",
          );

          // Notification details.
          const payload = {
            notification: {
              title: `A new message from ${contactName}!`,
              body: message,
              // icon: follower.photoURL
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              screen: "chat",
              args: contactId,
            },
          };
          // Send notifications to all tokens.
          const response = await admin.messaging().sendToDevice(tokenList, payload);
          // For each message check if there was an error.
          const tokensToRemove = [];
          response.results.forEach((result, index) => {
            const error = result.error;
            if (error) {
              functions.logger.error(
                  "Failure sending notification to",
                  tokenList[index],
                  error,
              );
              // Cleanup the tokens who are not registered anymore.
              if (error.code === "messaging/invalid-registration-token" ||
                  error.code === "messaging/registration-token-not-registered") {
                tokensToRemove.push(recipientSnapshot.ref.update("Tokens", tokenList.splice(index, 1)));
              }
            }
          });
          return Promise.all(tokensToRemove);
        });
