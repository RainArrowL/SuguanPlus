var basepath = path.resolve('.').split('.meteor')[0];

Excel = new FS.Collection("excels", {
  stores: [new FS.Store.FileSystem("excels", {path: "./data"})]
});

Excel.allow {
	insert: (userId, party)-> true
	update: (userId, party)-> true
	remove: (userId, party)-> true
	download: (userId, party)-> true
}

root = exports ? this
root.Excel = Excel