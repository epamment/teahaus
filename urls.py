from django.urls import path, include
from . import views
from rest_framework import routers
from .views import TeabyCategoryViewSet

router = routers.DefaultRouter()
router.register(r'category', views.CategoryViewSet)
router.register(r'tea', views.TeaViewSet)
router.register(r'tag', views.TagViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('category/<int:pk>/tea/', TeabyCategoryViewSet.as_view()),
    path('api-auth/', include('rest_framework.urls')),

]