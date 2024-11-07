from django.urls import path

from .views import HomeView, BookMarkDoc, LikeDoc, UserFollowView, GetConnection

urlpatterns = [
    path("document/fetch/<str:username>", HomeView.as_view(), name="fetch50"),
    path("document/like", LikeDoc.as_view(), name="like"),
    path("document/bookmark", BookMarkDoc.as_view(), name="bookmark"),
    
    path("user/follow/<str:username>", UserFollowView.as_view(), name="followUnFollow"),
    
    # path("user/check-follower", checkFollowing, name="checkFollowing"),
    
    path("user/fetch/<str:username>/<str:type>", GetConnection.as_view(), name="fetch_connection"),
]
