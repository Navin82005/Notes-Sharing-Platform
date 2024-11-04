from django.http import JsonResponse
from rest_framework.views import APIView

from utils import DB

class HomeView(APIView):
    def get(self, request, *args, **kwargs):
        acknowledgement = DB.fetch50()
        
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
