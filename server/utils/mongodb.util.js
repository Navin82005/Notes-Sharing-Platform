import mongoose from 'mongoose';
import Grid ;

// MongoDB connection URI
const mongoURI = 'mongodb://localhost:27017/mydatabase';

// Create MongoDB connection
const conn = mongoose.createConnection(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

// Initialize GridFS
let gfs;
conn.once('open', () => {
    gfs = Grid(conn.db, mongoose.mongo);
    gfs.collection('uploads');  // Set the collection for storing file metadata
});

// Export connection and GridFS stream
module.exports = { conn, gfs };
