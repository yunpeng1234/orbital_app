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
          // const followerUid = context.params.followerUid;
          // const followedUid = context.params.followedUid;
          const newValue = change.after.get("Done");
          const previousValue = change.before.get("Done");

          const orderDone = newValue !== previousValue;
          if (! orderDone) {
            return functions.logger.log({orderDone});
          }
          const orderId = context.params.orderId;
          const fromId = change.after.get("From");
          // If un-follow we exit the function.
          // if (!change.after.val()) {
          //     return functions.logger.log(
          //         "User ",
          //         followerUid,
          //         "un-followed user",
          //         followedUid
          //     );
          // }
          functions.logger.log(
              "We have a new completed order:",
              orderId,
              "placed by:",
              fromId,
          );

          // Get the list of device notification tokens.
          const getUserPromise = admin.firestore().collection("User").doc(fromId).get();

          // // Get the follower profile.
          // const getFollowerProfilePromise = admin.auth()
          // .getUser(followerUid);

          // The snapshot to the user's tokens.

          // The array containing all the user's tokens.

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
          // functions.logger.log("Fetched follower profile", follower);

          // Notification details.
          const payload = {
            notification: {
              title: `Your order (Order no. ${orderId}) has arrived!`,
              body: "Tap to verify.",
              // icon: follower.photoURL
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
        // const response = await admin.messaging()
        //     .sendToDevice(token, payload);
        // return functions.logger.log(response.results.toString());
        });
