from django.urls import path

from .views import HomeView, BookMarkDoc, LikeDoc

urlpatterns = [
    path("document/fetch", HomeView.as_view(), name="fetch50"),
    path("document/like", LikeDoc.as_view(), name="like"),
    path("document/bookmark", BookMarkDoc.as_view(), name="bookmark"),
]
