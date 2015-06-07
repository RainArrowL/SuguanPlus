Template.myForm.helpers({
  
});


Template.myForm.events({
  'submit #fileUpload': function(event, template) {
  	console.log("IN IT !\n");
    FS.Utility.eachFile(event, function(file) {
      Excel.insert(file, function (err, fileObj) {
        // Inserted new doc with ID fileObj._id, and kicked off the data upload using HTTP
      	console.log("in it !\n");
      });
    });
  }
});

