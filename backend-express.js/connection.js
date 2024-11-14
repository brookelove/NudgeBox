require("dotenv").config();
const mysql = require("mysql2");

// Create a connection to the database
const connection = mysql.createConnection({
  host: process.env.HOSTDB,
  user: process.env.USERDB,
  password: process.env.PASSWORDDB,
  database: process.env.DBNAME,
});

// Connect to the database
connection.connect((err) => {
  if (err) {
    console.error("error connecting: " + err.stack);
    return;
  }
  console.log("connected to database as id " + connection.threadId);
});

module.exports = connection;
