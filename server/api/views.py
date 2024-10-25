from django.http import JsonResponse

from rest_framework.views import APIView

from utils import DB


class GetDocuments(APIView):
    def get(request, *args, **kwargs):
        username = kwargs["username"]
        if username:
            documents = DB.get_documents(username=username)
            print("Documents from DB for", username, ":", documents)
            return JsonResponse(documents)

        return JsonResponse({"error": True, "message": "no username given"})
