const express = require("express");
const app = express();
const pool = require("./db");
const bodyParser = require('body-parser');



app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json())


app.set('view engine','ejs');




app.get("/orderTable/new", (req,res) => {
  res.render('NewOrder')
})

app.get("/", async (req,res) => {
  try{
    const productData = await pool.query("SELECT * FROM product;");

    res.render("homepage", {productList: productData.rows});
  }catch(err){
    console.log(err);
  }

})




app.get("/product", async (req,res) => {
  try{
    const newOrder = await pool.query("SELECT * FROM product;")
    res.send(newOrder);
  }catch(err){
    console.log(err);
  }
})

app.get("/caterer", async (req,res) => {
  try{
    const productList = await pool.query("SELECT * FROM product;")
    const orderList = await pool.query("SELECT * FROM orderTable;")

    res.render("caterer", {productList: productList.rows , orderList: orderList.rows});
  }catch(err){
    console.log(err);
  }
})

app.get("/caterer/product", async (req,res) => {
  try{
    const newOrder = await pool.query("SELECT * FROM product;")
    res.render(caterer);
  }catch(err){
    console.log(err);
  }
})


app.post("/caterer/product/new", async (req,res) => {
  try{
    const orderData = req.body;

    const newOrder = await pool.query("INSERT INTO product (product_id, product_name, availability, price) VALUES ($1, $2, $3, $4);", [
      orderData.product_id, orderData.product_name, orderData.availability, orderData.price
    ])
    res.redirect("/caterer");
  }catch(err){
    console.log(err);
  }
})



app.post("/caterer/product/delete", async (req,res) => {
  try{
    const productData = req.body;

    const queryResult = await pool.query("DELETE FROM product WHERE product_name = $1", [productData.product_id]);
    res.redirect("");
  }catch(err){
    console.log(err);
  }
})


app.get("/caterer/pendingOrder", async (req,res) => {
  try{

    const orderData = await pool.query("SELECT getPendingOrder();");
    res.redirect("/caterer");
    console.log(orderData);
  }catch(err){
    console.log(err);
  }
})

app.post("/order/new", async (req,res) => {
  try{
    const orderData = req.body;
    console.log(orderData);
    const productDetails = await pool.query("SELECT product_name, price FROM product WHERE product_id = $1", [orderData.product_id])
    console.log(productDetails);
    const queryResult = await pool.query("INSERT INTO orderTable (order_id, product_id, customer_name, amount, items) VALUES ($1,$2,$3,$4, $5);", [orderData.order_id, orderData.product_id, orderData.customer_name,productDetails.amount, orderData.quantity]);
    console.log("done");
    res.redirect("/");
  }catch(err){
    console.log(err);
  }
})


app.post("/orderTable/cancel", async (req,res) => {

try{
    const orderData = req.body;
    console.log(orderData);
    const queryResult = await pool.query("DELETE FROM orderTable WHERE order_id = $1", [orderData.order_id]);
    console.log("done");
    res.redirect("/");
  }catch(err){
    console.log(err);
  }
});



app.get("/customer", async (req,res) => {
  try {
    res.render("customer");
  }catch(err){
    console.log(err);
    res.redirect("/")
  }
})





// app.post("/orderTable/cancel")
//
// app.post("/orderTable/done")
//
// app.get("/customer/:id")
// app.get("/customer/all")
// app.post("/customer/newOrder")



app.listen(5000, () => {console.log("server Running");});
