import mysql from "mysql2";
import dotenv from "dotenv";

dotenv.config();

// Create a connection pool
const pool = mysql.createPool({
  host: process.env.HOST,
  user: process.env.USER,
  password: process.env.PASSWORD,
  database: process.env.DATABASE,
  port: 3306,
});

export default pool;
