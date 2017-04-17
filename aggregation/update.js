db.posts.find({}).forEach(
  function(doc){
    var size = doc.comments.length;
    doc.comments_size = size;
    db.posts.save(doc);
})
