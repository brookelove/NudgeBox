import express from "express";
import pool from "./db/connection.js";

const PORT = process.env.PORT || 3001;
const app = express();

// middleware
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

console.log("Database Configuration:", {
  host: process.env.HOST,
  user: process.env.USER,
  password: process.env.PASSWORD,
  database: process.env.DATABASE,
});

//connection to database
pool.getConnection((err, connection) => {
  if (err) {
    console.error("Connection error:", err.stack);
    return;
  }
  console.log("Connected to the database");
  connection.release();
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
