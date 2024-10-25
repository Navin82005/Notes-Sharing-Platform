from django.http import JsonResponse

from rest_framework.views import APIView

from utils import DB


class CreateUser(APIView):
    def post(self, request, *args, **kwargs):
        raw_user = request.data
        if raw_user:
            acknowledgement = DB.create_new_user(**raw_user)

            if acknowledgement["error"]:
                return JsonResponse(
                    {"error": True, "message": acknowledgement["message"]}, status=201
                )

            return JsonResponse(
                {"error": False, "user": acknowledgement["user"]}, status=201
            )

        return JsonResponse(
            {"error": True, "message": "invalid data passed"}, status=400
        )

    def delete(self, request, *args, **kwargs):
        raw_user = request.data
        if raw_user:
            new_user = DB.remove_user(raw_user["username"])

            return JsonResponse({"error": False, "user": new_user}, status=200)

        return JsonResponse(
            {"error": True, "message": "invalid data passed"}, status=400
        )

    def get(self, request, *args, **kwargs):
        try:
            username = request.data["username"]

            acknowledgement = DB.get_user(username)

            if acknowledgement["error"]:
                return JsonResponse(
                    {"error": True, "message": acknowledgement["message"]}
                )

            return JsonResponse({"error": False, "user": acknowledgement["user"]})
        except Exception as e:
            print("Error In Get User:", str(e))
            return JsonResponse({"error": True, "message": "parameter missing"})
