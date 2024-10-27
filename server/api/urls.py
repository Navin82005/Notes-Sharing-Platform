from django.urls import path

from .views import GetDocuments
from .users import UserView
from .documents import DocumentView, DocumentDownloadView

urlpatterns = [
    path("documents/<str:username>", DocumentView.as_view(), name="get_documents"),
    path("documents/download/<str:document_id>", DocumentDownloadView.as_view(), name="down_documents"),
    path("user/<str:username>", UserView.as_view(), name="create_user"),
]