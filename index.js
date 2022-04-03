const express = require("express");
const app = express();
const pool = require("./db");
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));

// parse application/json
app.use(bodyParser.json())
// Routes
// //orders
// app.get("/orders")

app.set('view engine','ejs');
app.get("/orders/new", (req,res) => {
  res.render('NewOrder')
})

app.post("/orders/new", async (req,res) => {
  try{
    const orderData = req.body;

    const newOrder = await pool.query("INSERT INTO products (product_id, product_name, availability, price) VALUES ($1, $2, $3, $4)", [
      orderData.product_id, orderData.product_name, orderData.availability, orderData.price
    ])
    res.redirect("/orders");
  }catch(err){
    console.log(err);
  }
})
//
// app.post("/orders/cancel")
//
// app.post("/orders/done")
//
// //products
// app.get("/products")
//
//
//
// //customer
//
// app.get("/customer/:id")
//
// app.get("/customer/all")
//
//
// app.post("/customer/newOrder")
//
//
// //caterer
//
// app.post("/caterer/products/new")
//
// app.post("/caterer/products/delete")
//
// //app.post("/caterer/products/modify")
//



app.listen(5000, () => {console.log("server Running");});
