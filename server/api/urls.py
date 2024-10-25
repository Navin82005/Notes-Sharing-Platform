from django.urls import path

from .views import GetDocuments
from .users import CreateUser
from .documents import DocumentView

urlpatterns = [
    path("documents", DocumentView.as_view(), name="get_documents"),
    path("user", CreateUser.as_view(), name="create_user"),
]