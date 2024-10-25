from django.urls import path

from .views import GetDocuments
from .users import CreateUser
from .documents import DocumentView, DocumentDownloadView

urlpatterns = [
    path("documents", DocumentView.as_view(), name="get_documents"),
    path("documents/download/<str:document_id>", DocumentDownloadView.as_view(), name="down_documents"),
    # path("documents/download", DocumentDownloadView.as_view(), name="down_documents"),
    path("user", CreateUser.as_view(), name="create_user"),
]