import json

from django.http import JsonResponse
from rest_framework.views import APIView

from utils import DB

class UserFollowView(APIView):
    def post(self, request, *args, **kwargs):
        data = request.data
        if not data:
            return JsonResponse({"error": True, "message": "missing required parameters"})
        print(data)
        # body = json.loads(data)
        body = data
        username = kwargs["username"]
        if body.__contains__("username"):
            alt_username = body["username"]
            acknowledgement = DB.followUnFollow(username, alt_username)
            if acknowledgement["error"]:
                return JsonResponse({"error": True, "message": acknowledgement["message"]})
            
            return JsonResponse({"error": False, "acknowledgement": True})
        return JsonResponse({"error": True, "message": "required fields are missing"})

class HomeView(APIView):
    def get(self, request, *args, **kwargs):
        if not kwargs.__contains__("username"):
            return JsonResponse({"error": True, "message": "username required"})
        acknowledgement = DB.fetch50(kwargs["username"])
        
        if acknowledgement["error"]:
            return JsonResponse({"error": True, "message": "no documents"})
        
        print(acknowledgement["documents"])
        return JsonResponse({"error": False, "documents": acknowledgement["documents"]})

class LikeDoc(APIView):
    def post(self, request, *args, **kwargs):
        data = {"username": request.data.get("username"), "document_id": request.data.get("document_id")}
        if "document_id" in data.keys() and "username" in data.keys():
            acknowledgement = DB.doc_like(data)
            if acknowledgement["error"]:
                return JsonResponse({"error": False, "message": acknowledgement["message"]})
                
            return JsonResponse({"error": False, "acknowledgement": True})
        
        return JsonResponse({"error": True, "message": "missing fields"})
    
    def delete(self, request, *args, **kwargs):
        data = {"username": request.data.get("username"), "document_id": request.data.get("document_id")}
        if "document_id" in data.keys() and "username" in data.keys():
            acknowledgement = DB.doc_unlike(data)
            if acknowledgement["error"]:
                return JsonResponse({"error": False, "message": acknowledgement["message"]})
                
            return JsonResponse({"error": False, "acknowledgement": True})
        
        return JsonResponse({"error": True, "message": "missing fields"})

class BookMarkDoc(APIView):
    def post(self, request, *args, **kwargs):
        data = {"username": request.data.get("username"), "document_id": request.data.get("document_id")}
        if "document_id" in data.keys() and "username" in data.keys():
            acknowledgement = DB.doc_bookmark(data)
            if acknowledgement["error"]:
                return JsonResponse({"error": False, "message": acknowledgement["message"]})
                
            return JsonResponse({"error": False, "acknowledgement": True})
        
        return JsonResponse({"error": True, "message": "missing fields"})
    
    def delete(self, request, *args, **kwargs):
        data = {"username": request.data.get("username"), "document_id": request.data.get("document_id")}
        if "document_id" in data.keys() and "username" in data.keys():
            acknowledgement = DB.doc_un_bookmark(data)
            if acknowledgement["error"]:
                return JsonResponse({"error": False, "message": acknowledgement["message"]})
                
            return JsonResponse({"error": False, "acknowledgement": True})
        
        return JsonResponse({"error": True, "message": "missing fields"})

class GetConnection(APIView):
    def post(self, request, *args, **kwargs):
        username = kwargs.pop("username")
        type = kwargs.pop("type")
        acknowledgement = None
        if type == "follower":
            acknowledgement = DB.get_followers(username)
        elif type == "following":
            acknowledgement = DB.get_following(username)
        
        if acknowledgement and acknowledgement["error"]:
            return JsonResponse({"error": True, "message": acknowledgement["message"]})
        else:
            return JsonResponse({"error": False, "users": acknowledgement["users"]})
        
        return JsonResponse({"error": True, "message": "Missing fields"})