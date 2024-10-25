from django.http import JsonResponse, FileResponse, HttpRequest
from rest_framework.views import APIView

from utils import DB


class DocumentView(APIView):
    def get(self, request, *args, **kwargs):
        if request.data.__contains__("username"):
            username = request.data["username"]
            acknowledgement = DB.get_documents(username=username)

            return JsonResponse({"error": False, "documents": acknowledgement})

        return JsonResponse({"error": True, "message": "required username"})

    def post(self, request, *args, **kwargs):
        
        if (request.data):
            print(request.data)
            acknowledgement = DB.put_document(request.data)
            return JsonResponse({"error": False, "acknowledgement": acknowledgement}, status=201)
        
        return JsonResponse({"error": True, "message": "no files sent"})

# class DocumentDownloadView(APIView):
#     def get(self, request: HttpRequest, *args, **kwargs):
#         request_body = request.data
        
#         if request_body.__contains__("document_id"):
#             document_id = request_body["document_id"]
#             print(document_id)
#             acknowledgement = DB.download_document(document_id)
#             if acknowledgement["error"]:
#                 return JsonResponse(acknowledgement)
            
#             file = acknowledgement["document"]
#             response = FileResponse(file, content_type=file.content_type)
#             response["Content-Disposition"] = f'inline; filename="{file.filename}"'
#             return response
#         return JsonResponse({"error": True, "message": "required document id"})

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
