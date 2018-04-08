
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
app.get('/rawMaterial',function(err,res){
    res.render('rawMaterial.html');
});
app.get('/production',function(err,res){
    res.render('production.html');
});
app.get('/shipment',function(err,res){
    res.render('shipping.html');
});
app.get('/logistic',function(err,res){
    res.render('logistic.html');
});

app.listen(3000,function () {
    console.log("Server started on port 3000");
});