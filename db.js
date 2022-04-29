const Pool = require("pg").Pool;

const pool = new Pool({
  user: "client",
  password: "abcdefg1",
  database: "canteen",
  host: "localhost",
  port: "5432",
});

module.exports = pool;
