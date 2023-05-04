const express = require('express');
const app = express();
const os = require('os');


app.get('/', (req, res) => {
    const hostname = os.hostname();
    res.send({ version: '1.0.1', hostname, message: 'this is new message in main' });
});

app.get('/health', (req, res) => {
    const hostname = os.hostname();

    res.send({ message: 'success', hostname });
});


const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
