const express = require("express");
const app = express();
const pool = require("./db");
const bodyParser = require("body-parser");

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.set("view engine", "ejs");

app.get("/orderTable/new", (req, res) => {
  res.render("NewOrder");
});

const logData = (query, output) => {
  console.log("~~~~Query/ Function~~~~");
  console.log(query, "\n");
  console.log("~~~~Output~~~~");
  console.log(output, "\n", "\n");
};

app.get("/", async (req, res) => {
  try {
    const productData = await pool.query("SELECT * FROM product;");
    logData("SELECT * FROM product;", productData.rows);
    res.render("homepage", { productList: productData.rows });
  } catch (err) {
    console.log(err);
  }
});

app.get("/product", async (req, res) => {
  try {
    const newOrder = await pool.query("SELECT * FROM product;");
    res.send(newOrder);
  } catch (err) {
    console.log(err);
  }
});

app.get("/caterer", async (req, res) => {
  try {
    const productList = await pool.query("SELECT * FROM product;");
    logData("SELECT * FROM product;", productList.rows);
    const orderList = await pool.query("SELECT * FROM orderTable;");
    logData("SELECT * FROM orderTable;", orderList.rows);
    res.render("caterer", {
      productList: productList.rows,
      orderList: orderList.rows,
    });
  } catch (err) {
    console.log(err);
  }
});




// get product list
app.get("/caterer/product", async (req, res) => {
  try {
    const newOrder = await pool.query("SELECT * FROM product;");
    logData("SELECT * FROM product;", newOrder.rows);
    res.render(caterer);
  } catch (err) {
    console.log(err);
  }
});
//
app.post("/caterer/product/new", async (req, res) => {
  try {
    const orderData = req.body;

    // const newOrder = await pool.query(
    //   "INSERT INTO product (product_id, product_name, availability, price) VALUES ($1, $2, $3, $4);",
    //   [
    //     orderData.product_id,
    //     orderData.product_name,
    //     orderData.availability,
    //     orderData.price,
    //   ]
    // );

    const newProduct = await pool.query(
      "CALL newProduct($1, $2, $3, $4);",
        [
          String(orderData.product_id),
          parseInt(orderData.price),
          String(orderData.product_name),
          Boolean(orderData.availability),
        ]
    )
    res.redirect("/caterer");
  } catch (err) {
    console.log(err);
  }
});
//delete the product
app.post("/caterer/product/delete", async (req, res) => {
  try {
    const productData = req.body;
    const queryResult = await pool.query(
      "DELETE FROM product WHERE product_id = $1",
      [parseInt(productData.product_id)]
    );
    res.redirect("/caterer");
  } catch (err) {
    console.log(err);
  }
});


// get pending order
app.get("/caterer/pendingOrder", async (req, res) => {
  try {
    const orderData = await pool.query("SELECT getPendingOrder();");
    res.redirect("/caterer");
    console.log(orderData);
  } catch (err) {
    console.log(err);
  }
});

app.get("/analytics", async (req, res) => {
  try {
    const totalSale = await pool.query("SELECT getTotalSale();");
    const totalOrders = await pool.query("SELECT getTotalOrders();");
    const customerCount = await pool.query("SELECT getCustomerCount();");
    const materialCost = await pool.query("SELECT getMaterialCost();");
    logData("SELECT getTotalSale();",totalSale.rows);
    logData("SELECT getTotalOrders();",totalOrders.rows);
    logData("SELECT getCustomerCount();",customerCount.rows);
    logData("SELECT getMaterialCost();",materialCost.rows);
    res.render("analytics",
    {
      totalSale: totalSale.rows[0].gettotalsale,
      totalOrders: totalOrders.rows[0].gettotalorders,
      customerCount: customerCount.rows[0].getcustomercount,
      materialCost: materialCost.rows[0].getmaterialcost
     });
  } catch (err) {
    console.log(err);
    res.redirect("/");
  }
});




//
// app.get("/caterer/pendingOrder", async (req, res) => {
//   try {
//     const orderData = await pool.query("SELECT getPendingOrder();");
//     res.redirect("/caterer");
//     console.log(orderData);
//   } catch (err) {
//     console.log(err);
//   }
// });
//
// app.post("/order/new", async (req, res) => {
//   try {
//     const orderData = req.body;
//     console.log(orderData);
//     // const productDetails = await pool.query(
//     //   "SELECT product_name, price FROM product WHERE product_id = $1",
//     //   [orderData.product_id]
//     // );
//     // console.log(productDetails);
//     // const queryResult = await pool.query(
//     //   "INSERT INTO orderTable (order_id, product_id, customer_name, amount, items) VALUES ($1,$2,$3,$4, $5);",
//     //   [
//     //     orderData.order_id,
//     //     orderData.product_id,
//     //     orderData.customer_name,
//     //     productDetails.amount,
//     //     orderData.quantity,
//     //   ]
//     // );
//     const queryResult = await pool.query(
//       "CALL newOrder(order_id, product_id, customer_name, amount, items) VALUES ($1,$2,$3,$4, $5);",
//       [
//         orderData.order_id,
//         orderData.product_id,
//         orderData.customer_name,
//         productDetails.amount,
//         orderData.quantity,
//       ]
//     );
//
//     logData("CALL order_id, product_id, customer_name, amount, items) VALUES ($1,$2,$3,$4, $5);", "done");
//     res.redirect("/");
//   } catch (err) {
//     console.log(err);
//   }
// });
//
// app.post("/orderTable/cancel", async (req, res) => {
//   try {
//     const orderData = req.body;
//     console.log(orderData);
//     const queryResult = await pool.query(
//       "DELETE FROM orderTable WHERE order_id = $1",
//       [orderData.order_id]
//     );
//     console.log("done");
//     res.redirect("/");
//   } catch (err) {
//     console.log(err);
//   }
// });
//
// app.get("/customer", async (req, res) => {
//   try {
//     res.render("customer");
//   } catch (err) {
//     console.log(err);
//     res.redirect("/");
//   }
// });
//
//
//
// app.get("/analytics", async (req, res) => {
//   try {
//     res.render("analytics");
//   } catch (err) {
//     console.log(err);
//     res.redirect("/");
//   }
// });

app.listen(5000, () => {
  console.log("server Running");
});
