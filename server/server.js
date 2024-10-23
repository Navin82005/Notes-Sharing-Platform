import multer from "multer";
import express from "express";
import mongoose from "mongoose";
import { server_config } from "./server.config.js";

const app = express();

app.use((req, res, next) => {
    console.log(`${req.method}: ${req.path}`);
    next();
})

mongoose.connect(server_config.mongodb_url);
console.log("Connected MongoDB");

const storage = multer.memoryStorage();
const upload = multer(storage)

app.use(express.static("public"));

const profileImageSchema = mongoose.Schema({
    username: String,
    filename: String,
    image: {
        data: Buffer,
        contentType: String,
    }
}, {
    timestamps: true,
})

const documentFileSchema = mongoose.Schema({
    username: String,
    filename: String,
    document: {
        data: Buffer,
        contentType: String,
    }
}, {
    timestamps: true,
})

const ImageModel = mongoose.model("ProfileImage", profileImageSchema);
const DocumentFile = mongoose.model("DocumentFile", documentFileSchema);

app.post('/user/upload', upload.single('file'), async (req, res) => {
    console.log(req.file);
    const document = DocumentFile({
        username: req.body.username,
        filename: req.file.originalname,
        document: {
            data: req.file.buffer,
            contentType: req.file.mimetype
        }
    });

    const newSavedDocument = await document.save();

    res.json(newSavedDocument);
});

app.get("/user/documents/:username", async (req, res) => {
    try {
        console.log("req.body.username: ");
        console.log(req.params.username);
        if (!req.params.username) {
            return res.json({ error: true, message: "username not found" });
        }

        const docs = await DocumentFile.find({ username: req.params.username });
        return res.json({ error: false, documents: docs });
    } catch (err) {
        console.log("Error in documents getting: " + err.message);
        return res.json({ error: false, message: err.message });
    }
})

app.listen(server_config.port, () => {
    console.log(`Server started on port http://localhost:${server_config.port}`);
});
