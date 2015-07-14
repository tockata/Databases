I have used MongoVUE management tool.
Database blog have been created using graphical tools of the MongoVUE. So there is no sql queries. New documents /rows/ are inserted simply by writing json objects /the same way like it is described below, but at point 3 using the first tab option, where there is an editor to write your json/.

Backup:
The only way to backup database with it is to export collections /tables/ to JSON file which 
later can be imported into another database. It saves json objects comma separated and it is necessary to delete commas between each document /row/ to be able to import the data - in this backup file I have removed commas.

To import the data:
1. Add new database;
2. Right click on the new data - select: Add collection. Give name to the collection and confirm. 
3. After that right click on the collection and choose Insert/Import documents and from the pop up window select second tab - Import multiple documents. 
4. Browse to the JSON backup file and import it.