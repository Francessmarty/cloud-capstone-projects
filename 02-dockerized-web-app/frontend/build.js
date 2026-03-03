const fs = require("fs");
const path = require("path");

const publicDir = path.join(__dirname, "public");
const distDir = path.join(__dirname, "dist");

if (!fs.existsSync(distDir)) {
  fs.mkdirSync(distDir);
}

fs.readdirSync(publicDir).forEach(file => {
  fs.copyFileSync(
    path.join(publicDir, file),
    path.join(distDir, file)
  );
});

console.log("Build completed successfully.");