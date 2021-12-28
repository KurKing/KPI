import http from "http"
import fs from "fs"

const server = http.createServer()

server.on("request", (req,res) => {
    if(req.method == "POST") {
        let data = {}
        new Promise((resolve) => {
            req.on("data", (chunk) => {
                let string = ""
                for(let char of chunk) {
                    string += String.fromCharCode(char)
                }
                data = JSON.parse(string)
                resolve(data)
            })
        })
        .then(data => save(data))
        return
    }
    res.writeHead(200, {"Content-Type": "text/plain",
        "access-control-allow-credentials": "true",
        "access-control-allow-origin": req.headers.origin});
    res.end(fs.readFileSync("./data/dropdown.json", "utf-8"));
})

function save(data) {
    fs.writeFileSync("./data/dropdown.json", JSON.stringify(data))
}
server.listen(3003)
