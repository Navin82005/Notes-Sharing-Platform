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

    def helperBook(self, doc, username):
        if not doc.__contains__("bookmarkedBy"):
            doc["bookmarkedBy"] = False
        elif doc.__contains__("bookmarkedBy"):
            if username in doc["bookmarkedBy"]:
                doc["bookmarkedBy"] = True
            else:
                doc["bookmarkedBy"] = False

    def helperLike(self, doc, username):
        if not doc.__contains__("likedBy"):
            doc["likedBy"] = False
        elif doc.__contains__("likedBy"):
            if username in doc["likedBy"]:
                doc["likedBy"] = True
            else:
                doc["likedBy"] = False

    def helperFollow(self, doc, user):
        following = user["following"]["accounts"]
        if doc["username"] in following:
            doc["isFollowedByUser"] = True
        else:
            doc["isFollowedByUser"] = False

    def helper_get_files(self, file_ids, username):
        document_collection = self.db["documents"]
        documents = []
        
        if file_ids:
            for id in file_ids:
                tmp = document_collection.find_one({"_id": ObjectId(id)})
                tmp["cover"] = str(tmp["cover"])
                tmp["_id"] = str(tmp["_id"])
                tmp["document"] = str(tmp["document"])
                self.helperBook(tmp, username)
                self.helperLike(tmp, username)
                self.helperFollow(tmp, self.db["users"].find_one({"username": username}))
                documents.append(tmp)
        return documents

    # NOTE DOCUMENT DATABASE SERVICES
    def get_documents(self, username: str, state: str = "uploaded") -> Dict[str, Union[bool, Dict[str, str], str]]:
        users = self.db["users"]
        find_user = users.find_one({"username": username})
        
        if find_user:
            if state == "saved":
                file_ids = list(find_user["bookmarked_docs"])
                documents = self.helper_get_files(file_ids, username)
                
                return {"error": False, "documents": documents}
            elif state == "uploaded":
                file_ids = list(find_user["files"])
                
                documents = self.helper_get_files(file_ids, username)
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
            
            profile = None
            
            if "profile" in user.keys():
                profile = user["profile"]
            
            new_document = {
                "username": data["username"],
                "displayName": user["display_name"],
                "profile": profile,
                "name": data["documentName"],
                "topic": data["topic"],
                "likes": 0,
                "description": description,
                "cover": str(cover_id),
                "coverName": cover_file_name,
                "document": str(file_id),
                "documentName": file_name,
                "dateOfUpload": datetime.now()
            }
            
            insert_acknowledgement = documents.insert_one(new_document)
            users.find_one_and_update({"_id": user["_id"]}, {"$push": {"files": insert_acknowledgement.inserted_id}})
            
            return {"error": False, "acknowledgement": True}
        except Exception as e:
            return {"error": True, "message": str(e)}

    def delete_document(self, document_data):
        document_collection = self.db["documents"]
        document = document_collection.find_one({"_id": ObjectId(document_data["document_id"])})
        users = self.db["users"]
        
        if document:
            newuser = users.update_one({"username": document_data["user_id"]}, {"$pull": {"files": ObjectId(document_data["document_id"])}})
            print("newuser:", newuser)
            if document["cover"] != None:
                self.gridFS.delete(ObjectId(document["cover"]))
            if document["document"] != None:
                self.gridFS.delete(ObjectId(document["document"]))
            document_collection.delete_one({"_id": ObjectId(document["_id"])})
            return {"error": False, "acknowledgement": True}
        
        return {"error": True, "message": "invalid document id"}

    def get_document(self, document_id):
        document_collection = self.db["documents"]
        document = document_collection.find_one({"_id": ObjectId(document_id)})
        if document:
            document["cover"] = str(document["cover"])
            document["_id"] = str(document["_id"])
            document["document"] = str(document["document"])
            self.helperBook(document, "")
            self.helperFollow(document, "")
            self.helperLike(document, "")
            return {"error": False, "document": document}
        
        return {"error": True, "message": "invalid document id"}

    def fetch50(self, username):
        find_user = self.db["users"].find_one({"username": username})
        if not find_user:
            return {"error": True, "message": "invalid username"}
        try:
            documents_collection = self.db["documents"]
            documents = documents_collection.find({}).limit(50)
            documents = list(documents)
            for i in documents:
                i["_id"] = str(i["_id"])
                self.helperBook(i, username)
                self.helperLike(i, username)
                self.helperFollow(i, find_user)
                print(i["username"] in find_user["following"]["accounts"])
            return {"error": False, "documents": documents}
        except Exception as e:
            print("Error Utils.fetch50:" + str(e))
            return {"error": True, "message": str(e)}


    def doc_like(self, data):
        try:
            user = self.db["users"].find_one({"username": data["username"]})
            document = self.db["documents"].find_one({"_id": ObjectId(data["document_id"])})
            
            if user and document:
                self.db["users"].update_one({"username": data["username"]}, {"$push": {"liked_docs": str(document["_id"])}})
                self.db["documents"].update_one({"_id": ObjectId(data["document_id"])}, {"$inc": {"likes": 1}})
                self.db["documents"].update_one({"_id": ObjectId(data["document_id"])}, {"$push": {"likedBy": data["username"]}})
                return {"error": False, "acknowledgement": True}
            return {"error": True, "message": "no documents matching"}
        
        except Exception as e:
            return {"error": True, "message": str(e)}

    def doc_unlike(self, data):
        try:
            user = self.db["users"].find_one({"username": data["username"]})
            document = self.db["documents"].find_one({"_id": ObjectId(data["document_id"])})
            
            if user and document:
                self.db["users"].update_one({"username": data["username"]}, {"$pull": {"liked_docs": str(document["_id"])}})
                self.db["documents"].update_one({"_id": ObjectId(data["document_id"])}, {"$inc": {"likes": -1}})
                self.db["documents"].update_one({"_id": ObjectId(data["document_id"])}, {"$pull": {"likedBy": data["username"]}})
                return {"error": False, "acknowledgement": True}
            return {"error": True, "message": "no documents matching"}
        
        except Exception as e:
            return {"error": True, "message": str(e)}
    
    def doc_bookmark(self, data):
        try:
            user = self.db["users"].find_one({"username": data["username"]})
            document = self.db["documents"].find_one({"_id": ObjectId(data["document_id"])})
            
            if user and document:
                self.db["users"].update_one({"username": data["username"]}, {"$push": {"bookmarked_docs": str(document["_id"])}})
                self.db["documents"].update_one({"_id": ObjectId(data["document_id"])}, {"$push": {"bookmarkedBy": data["username"]}})
                return {"error": False, "acknowledgement": True}
            return {"error": True, "message": "no documents matching"}
        
        except Exception as e:
            return {"error": True, "message": str(e)}

    def doc_un_bookmark(self, data):
        try:
            user = self.db["users"].find_one({"username": data["username"]})
            document = self.db["documents"].find_one({"_id": ObjectId(data["document_id"])})
            
            if user and document:
                self.db["users"].update_one({"username": data["username"]}, {"$pull": {"bookmarked_docs": str(document["_id"])}})
                self.db["documents"].update_one({"_id": ObjectId(data["document_id"])}, {"$pull": {"bookmarkedBy": data["username"]}})
                return {"error": False, "acknowledgement": True}
            return {"error": True, "message": "no documents matching"}
        
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

    def get_user(self, username: str, alt_user: str = None) -> Dict[str, Union[bool, Dict[str, str], str]]:
        try:
            users = self.db["users"]
            
            find_user = users.find_one({"username": username}, {"_id": 0})
            if alt_user and find_user:
                alt_user = users.find_one({"username": alt_user}, {"_id": 0})
                if alt_user:
                    alt_user["isFollowedByUser"] = False
                    if alt_user["username"] in find_user["following"]["accounts"]:
                        alt_user["isFollowedByUser"] = True
                    for id in range(len(alt_user["files"])):
                        alt_user["files"][id] = str(alt_user["files"][id])
                    if alt_user.__contains__("liked_docs"):
                        alt_user.pop("liked_docs")
                    if alt_user.__contains__("bookmarked_docs"):
                        alt_user.pop("bookmarked_docs")
                    if alt_user.__contains__("notifications"):
                        alt_user.pop("notifications")
                        
                    alt_user["following"] = alt_user["following"]["count"]
                    alt_user["followers"] = alt_user["followers"]["count"]
                    # print(alt_user)
                    return {"error": False, "user": alt_user}
                return {"error": True, "message": "no such user"}
            
            elif find_user:
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
                    documents.delete_one({"_id": ObjectId(document["_id"])})
                users.delete_one({"username": username})
                return {"error": False, "data": "removed user"}
            return {"error": True, "data": "no users found"}
        except Exception as e:
            return {"error": True, "data": str(e)}

    def login(self, username, password):
        user = self.db["users"].find_one({"username": username, "password": password}, {"_id": 0, "password": 0})
        print(user)
        for fil in range(len(user["files"])):
            user["files"][fil] = str(user["files"][fil])
            
        if user:
            return {"error": False, "user": user}
        
        return {"error": True, "message": "no users found"}

    def followUnFollow(self, username, alt_username):
        users = self.db["users"]
        main_user = users.find_one({"username": username})
        follow_user = users.find_one({"username": alt_username})
        if main_user:
            if follow_user:
                if follow_user["username"] in main_user["following"]["accounts"]:
                    users.update_one({"username": username}, { "$pull" : {"following.accounts": alt_username}, "$inc" : {"following.count": -1}})
                    users.update_one({"username": alt_username}, { "$pull" : {"followers.accounts": username}, "$inc" : {"followers.count": -1}})
                else:
                    users.update_one({"username": username}, { "$push" : {"following.accounts": alt_username}, "$inc" : {"following.count": 1}})
                    users.update_one({"username": alt_username}, { "$push" : {"followers.accounts": username}, "$inc" : {"followers.count": 1}}, upsert=True)
                return {"error": False, "acknowledgement": True}
            else:
                return {"error": True, "message": "unknown follow user"}
        return {"error": True, "message": "unknown user"}


    def get_followers(self, username):
        users_collection = self.db["users"]
        find_user = users_collection.find_one({"username": username}, {"_id": 0})
        if find_user is not None:
            users = []
            followers = find_user["followers"]["accounts"]
            print("followers: ", followers)
            for follower in followers:
                user = users_collection.find_one({"username": follower}, {"_id": 0})
                user.pop("followers")
                user.pop("following")
                user.pop("files")
                user["isFollowedByUser"] = True
                users.append(user)
            return {"error": False, "users": users}
        return {"error": True, "message": "invalid username"}

    def get_following(self, username):
        users_collection = self.db["users"]
        find_user = users_collection.find_one({"username": username}, {"_id": 0})
        if find_user is not None:
            users = []
            following = find_user["following"]["accounts"]
            for follow in following:
                user = users_collection.find_one({"username": follow}, {"_id": 0})
                user.pop("followers")
                user.pop("following")
                user.pop("files")
                user.pop("password")
                if user.__contains__("liked_docs"):
                    user.pop("liked_docs")
                if user.__contains__("bookmarked_docs"):
                    user.pop("bookmarked_docs")
                if user.__contains__("notifications"):
                    user.pop("notifications")
                    
                user["isFollowedByUser"] = False
                users.append(user)
            return {"error": False, "users": users}
        return {"error": True, "message": "invalid username"}
        
DB = MongoDBConnector(connection_string=mongo_connection_string)
print("Created database connection object:")
