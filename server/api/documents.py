import json
from django.http import JsonResponse, FileResponse, HttpRequest
from rest_framework.views import APIView

from utils import DB


class SavedDocumentView(APIView):
    def get(self, request, *args, **kwargs):
        if kwargs.__contains__("username"):
            username = kwargs["username"]
            acknowledgement = DB.get_documents(username=username, state="saved")
            if acknowledgement["error"]:
                return JsonResponse({"error": True, "message": acknowledgement["message"]})

            return JsonResponse({"error": False, "documents": acknowledgement["documents"]})

        return JsonResponse({"error": True, "message": "required username"})

class DocumentView(APIView):
    def get(self, request, *args, **kwargs):
        if kwargs.__contains__("username"):
            username = kwargs["username"]
            acknowledgement = DB.get_documents(username=username)
            if acknowledgement["error"]:
                return JsonResponse({"error": True, "message": acknowledgement["message"]})

            return JsonResponse({"error": False, "documents": acknowledgement["documents"]})

        return JsonResponse({"error": True, "message": "required username"})

    def post(self, request, *args, **kwargs):
        
        if (request.data):
            acknowledgement = DB.put_document(request.data, request.FILES.getlist("document"))
            if acknowledgement["error"]:
                return JsonResponse({"error": True, "message": acknowledgement["message"]})
            return JsonResponse({"error": False, "acknowledgement": acknowledgement["acknowledgement"]}, status=201)
        
        return JsonResponse({"error": True, "message": "no files sent"})
    
    def delete(self, request, *args, **kwargs):
        print(args)
        body = json.loads(request.body)
        if "document_id" in body.keys() and "user_id" in body.keys():
            acknowledgement = DB.delete_document(document_data=body)
            
            if acknowledgement["error"]:
                return JsonResponse({"error": True, "message": acknowledgement["message"]})
            
            return JsonResponse({"error": True, "acknowledgement": acknowledgement["acknowledgement"]})
        
        return JsonResponse({"error": True, "message": "no file id sent"})

def get_single_document(request):
    try:
        body = json.loads(request.body)
        print("Body in get_single_document:", body)
        if "document_id" in body.keys():
            
            acknowledgement = DB.get_document(body["document_id"])
            if acknowledgement["error"]:
                return JsonResponse({"error": True, "message": acknowledgement["message"]})
                
            
            return JsonResponse({"error": False, "document": acknowledgement["document"]})
        return JsonResponse({"error": True, "message": "no document id sent"})
    except Exception as e:
        return JsonResponse({"error": True, "message": str(e)})

class DocumentDownloadView(APIView):
    def get(self, request: HttpRequest, *args, **kwargs):
        request_body = kwargs
        
        if request_body.__contains__("document_id"):
            document_id = request_body["document_id"]
            acknowledgement = DB.download_document(document_id)
            if acknowledgement["error"]:
                return JsonResponse(acknowledgement)
            
            file = acknowledgement["document"]
            response = FileResponse(file, content_type=file.content_type)
            response["Content-Disposition"] = f'inline; filename="{file.filename}"'
            return response
        return JsonResponse({"error": True, "message": "required document id"})
