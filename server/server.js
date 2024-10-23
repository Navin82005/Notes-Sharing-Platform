import express from 'express';
import { server_config } from './server.config.js';

const app = express();

console.log(`Server starting...`);
app.listen(server_config.port, () => {
    console.log(`Server started. Listen on port http://localhost:${server_config.port}`);
});
