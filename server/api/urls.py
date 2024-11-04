from django.urls import path

from .views import GetDocuments
from .users import UserView, UserLogin
from .documents import DocumentView, DocumentDownloadView, get_single_document

urlpatterns = [
    path("user/login/<str:mode>", UserLogin.as_view(), name="create_user"),
    
    path("document/", get_single_document, name="get_single_document"),
    path("documents/<str:username>", DocumentView.as_view(), name="get_documents"),
    path("documents/download/<str:document_id>", DocumentDownloadView.as_view(), name="down_documents"),
    
    path("user/<str:username>", UserView.as_view(), name="create_user"),
]