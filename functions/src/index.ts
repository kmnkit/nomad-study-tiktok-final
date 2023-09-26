import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const onMoodCreated = functions.firestore
  .document("moods/{moodId}")
  .onCreate(async (snapshot, __) => {
    await snapshot.ref.update({ id: snapshot.id });
  });
