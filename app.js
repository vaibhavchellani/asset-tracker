
var express     =   require('express');
var app         =   express();
app.set('views', __dirname + '/views');
app.use(express.static(__dirname + '/public'));

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
app.get('/rawMaterialDash',function(err,res){
    res.render('rawMaterialDash.html');
});
app.get('/productionDash',function(err,res){
    res.render('productionDash.html');
});
app.get('/shippingDash',function(err,res){
    res.render('shippingDash.html');
});
app.get('/logisticDash',function(err,res){
    res.render('logisticDash.html');
});
app.get('/readyDash',function(err,res){
    res.render('readyDash.html');
});
app.listen(3000,function () {
    console.log("Server started on port 3000");
});