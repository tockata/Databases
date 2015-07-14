-- create db chat:
use chat

-- create db user:
db.createUser({user: "user", pwd: "user123", roles: ["readWrite", "dbOwner"]})

-- insert some documents in db:
var bulk = db.messages.initializeUnorderedBulkOp();
bulk.insert({ text: "Hello", date: new Date('24 June 2015'), isRead: true, user: { username: "pesho", fullName: "Petar Petrov", website: "www.petar.com"}});
bulk.insert({ text: "Hi Pesho", date: new Date('25 June 2015'), isRead: false, user: { username: "gosho", fullName: "Georgi Georgiev", website: "www.georgi.com"}});
bulk.insert({ text: "How are you?", date: new Date('25 June 2015'), isRead: true, user: { username: "pesho", fullName: "Petar Petrov", website: "www.petar.com"}});
bulk.insert({ text: "I am alright, thank you. And you?", date: new Date('26 June 2015'), isRead: false, user: { username: "gosho", fullName: "Georgi Georgiev", website: "www.georgi.com"}});
bulk.insert({ text: "I am ok too :)", date: new Date('09 July 2015'), isRead: true, user: { username: "pesho", fullName: "Petar Petrov", website: "www.petar.com"}});
bulk.execute();

-- use mongodump to backup database - open cmd as administrator and run mongodump. Backup will be created in the same folder as mongodump in folder named "dump":
C:\Program Files\MongoDB\Server\3.0\bin>mongodump --db chat

-- To specify a different output directory, you can use the --out or -o option: mongodump --out /data/backup/
