from django.http import JsonResponse, FileResponse
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
            return JsonResponse({"error": False, "metadata": request.data["file"].name}, status=201)
        
        return JsonResponse({"error": True, "message": "no files sent"})
    