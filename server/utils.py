from typing import Dict, Union

from pymongo import MongoClient
from pymongo.collection import InsertOneResult
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
        print("find_user:", find_user)
        if find_user:
            documents = []
            filenames = list(find_user["files"])
            if filenames:
                for i in filenames:
                    file = self.gridFS.find(filename=i)
                    documents.append(file)
                return {"error": False, "data": documents}
            else:
                return {"error": True, "data": "no documents found"}
        else:
            return {"error": True, "data": f"no users found for {username}"}

    def put_document(self, data):
        try:
            username = data["username"]
            users = self.db["users"]
            user = users.find_one({"username": username})
            if not user:
                return {"error": True, "message": f"no users found for {username}"}
            
            documents = self.db["documents"]
            
            description = ""
            if data.__contains__("description"):
                description = data["description"]
            
            cover = None
            if data.__contains__("cover"):
                cover = data["cover"]
            
            if not data.__contains__("document"):
                return {"error": True, "message": "Document must be sent"}
            
            file = data["document"]
            file_id = self.gridFS.put(file.file)
            
            new_document = {
                "name": data["documentName"],
                "topic": data["topic"],
                "likes": 0,
                "description": description,
                "cover": cover,
                "document": file_id,
                "dateOfUpload": datetime.now()
            }
            
            insert_acknowledgement = documents.insert_one(new_document)
            users.find_one_and_update({"_id": user["_id"]}, {"$push": {"files": insert_acknowledgement.inserted_id}})
            
            # documents.insert_one({"name"})
            # f_id = self.gridFS.put(data["file"].file)
            # print(f_id)
            # return {"error": False, "data" : str(f_id)}
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
                print(find_user)

                if not find_user:
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
                return {"error": False, "user": find_user}
            return {"error": True, "message": "no such user"}
        except Exception as e:
            return {"error": True, "message": str(e)}

    def remove_user(self, username) -> Dict[str, Union[bool, Dict[str, str], str]]:
        try:
            users = self.db["users"]
            find_user = users.find_one({"username": username})

            if find_user:
                users.delete_one({"username": username})
                return {"error": False, "data": "removed user"}
            return {"error": True, "data": "no users found"}
        except Exception as e:
            return {"error": True, "data": str(e)}


DB = MongoDBConnector(connection_string=mongo_connection_string)
print("Created database connection object:")
