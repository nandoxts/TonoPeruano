const http = require("http");
const fs = require("fs");
const path = require("path");

const BASE = path.join(__dirname, "src");
let count = 0;

const server = http.createServer((req, res) => {
  if (req.method !== "POST") {
    res.writeHead(405);
    res.end();
    return;
  }

  let body = "";
  req.on("data", chunk => (body += chunk.toString("utf8")));
  req.on("end", () => {
    const filePath = path.join(BASE, req.url.replace(/\//g, path.sep));
    const dir = path.dirname(filePath);
    fs.mkdirSync(dir, { recursive: true });
    fs.writeFileSync(filePath, body, "utf8");
    count++;
    console.log(`[${count}] Guardado: ${filePath}`);
    res.writeHead(200);
    res.end("OK");
  });
});

server.listen(8765, "127.0.0.1", () => {
  console.log("=== Servidor listo en http://127.0.0.1:8765 ===");
});
