from django.http import JsonResponse

from rest_framework.views import APIView

from utils import DB

class UserLogin(APIView):
    def post(self, request, *args, **kwargs):
        try:
            mode = kwargs.pop('mode')
            if mode == 'email':
                body = request.data
                print("Body:", body)
                if body["username"]:
                    acknowledgement = DB.login(username=body["username"], password=body["password"])
                    if acknowledgement["error"]:
                        return JsonResponse({"error": True, "message": acknowledgement["message"]})
                    return JsonResponse({"error": False, "user": acknowledgement["user"]})
                return JsonResponse({"error": True, "message": "unknown user"})
            else:
                return JsonResponse({"error": True, "message": "unknown method"})
        except Exception as e:
            print("Internal Server Error: " + str(e))
            return JsonResponse({"error": True, "message": "fields missing"})

class UserView(APIView):
    def post(self, request, *args, **kwargs):
        raw_user = kwargs["username"]
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
        raw_user = kwargs["username"]
        if raw_user:
            new_user = DB.remove_user(raw_user)

            return JsonResponse({"error": False, "user": new_user}, status=200)

        return JsonResponse(
            {"error": True, "message": "invalid data passed"}, status=400
        )

    def get(self, request, *args, **kwargs):
        try:
            username = kwargs["username"]

            acknowledgement = DB.get_user(username)

            if acknowledgement["error"]:
                return JsonResponse(
                    {"error": True, "message": acknowledgement["message"]}
                )
            user = acknowledgement["user"]
            user["files"] = len(user["files"])
            user["followers"] = user["followers"]["count"]
            user["following"] = user["following"]["count"]

            return JsonResponse({"error": False, "user": acknowledgement["user"]})
        except Exception as e:
            print("Error In Get User:", str(e))
            return JsonResponse({"error": True, "message": "parameter missing"})
