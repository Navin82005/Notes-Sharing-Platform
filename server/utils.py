from typing import Dict, Union

from django.http import QueryDict
from pymongo import MongoClient
from bson.objectid import ObjectId
import gridfs as gf


from datetime import datetime
from config import mongo_connection_string



class MongoDBConnector:
    def __init__(self, connection_string: str, database: str = None):
        print("Connecting to MongoDB...")
        self.connection = None
        try:
            self.connection = MongoClient(connection_string)
        except Exception as e:
            print("Error connecting to MongoDB:", str(e))
            exit(1)
        self.db = self.connection.get_database()
        print("Successfully connected to MongoDB:", self.db.name)
        try:
            self.gridFS = None
            if database == None:
                self.gridFS = gf.GridFS(self.db)
            else:
                self.gridFS = gf.GridFS(self.connection[database])
        except Exception as e:
            print("Error connecting to GridFS:", str(e))
            exit(1)
        print("Successfully connected to GridFS")


    # NOTE DOCUMENT DATABASE SERVICES
    def get_documents(self, username: str) -> Dict[str, Union[bool, Dict[str, str], str]]:
        users = self.db["users"]
        find_user = users.find_one({"username": username})
        document_collection = self.db["documents"]
        
        if find_user:
            documents = []
            file_ids = list(find_user["files"])
            # print(file_ids)
            if file_ids:
                for id in file_ids:
                    tmp = document_collection.find_one({"_id": id}, {"_id": 0})
                    tmp["cover"] = str(tmp["cover"])
                    tmp["document"] = str(tmp["document"])
                    documents.append(tmp)
                print("Documents:", documents)
                return {"error": False, "documents": documents}
            else:
                return {"error": True, "message": "no documents found"}
        else:
            return {"error": True, "message": f"no users found for {username}"}


    def download_document(self, document_id):
        try:
            document = self.gridFS.get_last_version(_id=ObjectId(document_id))
            print(document)
            if document:
                return {"error": False, "document": document}
            return {"error": True, "message": "no document found"}
        # except gf.errors.NoFile:
            # return {"error": True, "message": "no document found"}
        except Exception as e:
            return {"error": True, "message": str(e)}


    def put_document(self, data: QueryDict, files: list):
        try:
            print(files)
            username = data["username"]
            users = self.db["users"]
            user = users.find_one({"username": username})
            if not user:
                return {"error": True, "message": f"no users found for {username}"}
            
            documents = self.db["documents"]
            
            description = ""
            if data.__contains__("description"):
                description = data["description"]
            
            if not data.__contains__("document"):
                return {"error": True, "message": "Document must be sent"}
            
            file_data = files[0].read()
            file_name = files[0].name
            file_content_type = files[0].content_type
            
            cover_file_data = files[1].read()
            cover_file_name = files[1].name
            cover_content_type = files[1].content_type
            
            file_id = self.gridFS.put(file_data, filename=file_name, contentType=file_content_type)
            cover_id = self.gridFS.put(cover_file_data, filename=cover_file_name, contentType=cover_content_type)
            
            new_document = {
                "name": data["documentName"],
                "topic": data["topic"],
                "likes": 0,
                "description": description,
                "cover": cover_id,
                "coverName": cover_file_name,
                "document": file_id,
                "documentName": file_name,
                "dateOfUpload": datetime.now()
            }
            
            insert_acknowledgement = documents.insert_one(new_document)
            users.find_one_and_update({"_id": user["_id"]}, {"$push": {"files": insert_acknowledgement.inserted_id}})
            
            return {"error": False, "acknowledgement": True}
        except Exception as e:
            return {"error": True, "message": str(e)}


    # NOTE USER DATABASE SERVICES
    def create_new_user(self, **user_data) -> Dict[str, Union[bool, Dict[str, str], str]]:
        try:
            if user_data["username"]:
                username = user_data["username"]
                users = self.db["users"]
                find_user = users.find_one({"username": username})
                user_data["files"] = []

                if not find_user:
                    user_data["likes"] = 0
                    user_data["followers"] = {"count": 0, "accounts": []}
                    user_data["following"] = {"count": 0, "accounts": []}
                    print("User created successfully:", user_data)
                    users.insert_one(user_data)
                    new_user = users.find_one({"username": username}, {"_id": 0})
                    print(new_user)
                    return {"error": False, "user": new_user}
                    # return {"error": False, "data": username}
                return {"error": True, "message": "username already exists"}
        except Exception as e:
            return {"error": True, "message": str(e)}
        return {"error": True, "message": "Invalid parameters"}

    def get_user(self, username: str) -> Dict[str, Union[bool, Dict[str, str], str]]:
        try:
            users = self.db["users"]

            find_user = users.find_one({"username": username}, {"_id": 0})
            
            if find_user:
                for id in range(len(find_user["files"])):
                    find_user["files"][id] = str(find_user["files"][id])
                    
                return {"error": False, "user": find_user}
            return {"error": True, "message": "no such user"}
        except Exception as e:
            print("Log in get_user:", str(e))
            return {"error": True, "message": str(e)}

    def remove_user(self, username) -> Dict[str, Union[bool, Dict[str, str], str]]:
        try:
            users = self.db["users"]
            find_user = users.find_one({"username": username})
            documents = self.db["documents"]
            
            if find_user:
                for doc_id in find_user["files"]:
                    document = documents.find_one({"_id": ObjectId(doc_id)})
                    if document:
                        if document["cover"] != None:
                            self.gridFS.delete(document["cover"])
                        if document["document"] != None:
                            self.gridFS.delete(document["document"])
                users.delete_one({"username": username})
                return {"error": False, "data": "removed user"}
            return {"error": True, "data": "no users found"}
        except Exception as e:
            return {"error": True, "data": str(e)}

    def login(self, username, password):
        user = self.db["users"].find_one({"username": username, "password": password}, {"_id": 0, "password": 0})
        print(user)
        if user:
            return {"error": False, "user": user}
        
        return {"error": True, "message": "no users found"}

DB = MongoDBConnector(connection_string=mongo_connection_string)
print("Created database connection object:")
