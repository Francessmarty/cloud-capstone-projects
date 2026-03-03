const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");

const app = express();
app.use(cors());
app.use(express.json());

// MySQL connection (values will come from docker-compose env vars)
const dbConfig = {
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "appuser",
  password: process.env.DB_PASSWORD || "apppass",
  database: process.env.DB_NAME || "appdb",
};

// Health endpoint
app.get("/ping", (req, res) => {
  res.json({ status: "pong" });
});

// Fetch inventory for dashboard table
app.get("/inventory", async (req, res) => {
  try {
    const conn = await mysql.createConnection(dbConfig);
    const [rows] = await conn.query(
      "SELECT id, item_name, sku, qty, location, updated_at FROM inventory ORDER BY id ASC"
    );
    await conn.end();
    res.json({ rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "DB error", error: err.message });
  }
});

// Signup (kept simple for capstone)
app.post("/signup", (req, res) => {
  const { name, email, password } = req.body;
  if (!name || !email || !password) {
    return res.status(400).json({ message: "Name, email and password required." });
  }
  res.json({ message: `Account Successfully Created` });
});

// Login (kept simple for capstone)
app.post("/login", (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ message: "Email and password required." });
  }
  res.json({ message: `Successfully Logged in` });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Backend listening on ${PORT}`);
});