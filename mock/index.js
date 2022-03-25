const express = require('express')
const app = express()
const server = require('http').createServer(app)
const fs = require('fs')

app.use(express.json())

app.post('/login', function (req, res) {
    let { username, password } = req.body
    if (username === 'user' && password === 'pass') {
        res.send(true)
    } else {
        res.send(false)
    }
})

app.post('/saveStatement', function (req, res) {
    let { id, name, type } = req.body

    var data = fs.readFileSync('./json/statements.json')
    var json = JSON.parse(data)
    json.push({
        "id": id,
        "name": name,
        "type": type
    })

    try {
        fs.writeFileSync("./json/statements.json", JSON.stringify(json))
        res.sendStatus(200)
        console.log('saved')
    } catch (error) {
        res.sendStatus(400)
    }
})

app.post('/deleteStatement', function (req, res) {
    let { id } = req.body
    console.log(id)
    var data = fs.readFileSync('./json/statements.json')
    var json = JSON.parse(data)

    json = json.filter((item) => {
        return item.id !== id
    })

    try {
        fs.writeFileSync('./json/statements.json', JSON.stringify(json))
        let statementsJson = require('./json/statements.json')
        res.json(statementsJson)
    } catch (error) {
        res.sendStatus(400)
    }
})

app.get('/statements', function (req, res) {
    let statementsJson = require('./json/statements.json')
    res.json(statementsJson)
})

server.listen(3000, '0.0.0.0', function () {
    console.log('Application started')
    console.log('Port: 3000')
})