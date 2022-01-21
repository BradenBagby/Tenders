const functions = require('firebase-functions');
const admin = require('firebase-admin');


/// listen for user to disconnect, check all other users, if all have disconnected then cleanup the room
/*exports.cleanupRoom = functions.firestore
    .document('/rooms/{roomId}/members/{memberId}')
    .onUpdate(async(snapshot, context) => {
        if (snapshot.after != null) {
            const data = snapshot.after.data();
            if (data.disconnected) {
                // check if every member is disconnected and clear
                const members = await snapshot.after.ref.parent.get();
                const disconnected = members.docs.filter((e) => e.data()['disconnected']);
                if (members.docs.length == disconnected.length) {
                    // all members have been disconnected so delete the group
                    const roomId = context.params.roomId;
                    const db = admin.firestore();
                    await deleteQueryBatch(db, db.collection(`/rooms/${roomId}`), 100);
                }
            }
        }
    });
*/
/*
const runtimeOpts = {
    timeoutSeconds: 540,
    memory: '1GB'
}

/// clean up every room that is too old
exports.dailySchedule = functions.runWith(runtimeOpts).pubsub.schedule('every 2 minutes').onRun(async(context) => {
    
});


function deleteQueryBatch(db, query, batchSize) {
    return new Promise((resolve, reject) => {
        query.get()
            .then((snapshot) => {
                // When there are no documents left, we are done
                if (snapshot.size == 0) {
                    return 0;
                }

                // Delete documents in a batch
                let batch = db.batch();
                snapshot.docs.forEach((doc) => {
                    batch.delete(doc.ref);
                });

                return batch.commit().then(() => {
                    return snapshot.size;
                });
            }).then((numDeleted) => {
                if (numDeleted === 0) {
                    resolve();
                    return;
                }

                // Recurse on the next process tick, to avoid
                // exploding the stack.
                process.nextTick(() => {
                    deleteQueryBatch(db, query, batchSize);
                });
            })
            .catch(reject);
    });
}
*/