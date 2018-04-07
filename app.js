
var express     =   require('express');
var app         =   express();
app.set('views', __dirname + '/views');
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'ejs');
app.get('/placeOrder',function(err,res){
    res.render('placeOrder.html');
});
app.get('/getAssetDetails',function(err,res){
    res.render('assetDetails.html');
});
app.listen(3000,function () {
    console.log("Server started on port 3000");
});