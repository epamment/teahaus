from .models import Category, Tea, Tag
from rest_framework import viewsets, generics
from rest_framework import permissions
from .serializer import CategorySerializer, TeaSerializer, TagSerializer

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = [permissions.IsAuthenticated]


class TeaViewSet(viewsets.ModelViewSet):
    queryset = Tea.objects.all()
    serializer_class = TeaSerializer
    permission_classes = [permissions.IsAuthenticated]


class TagViewSet(viewsets.ModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer
    permission_classes = [permissions.IsAuthenticated]

class TeabyCategoryViewSet(generics.ListAPIView):
    serializer_class = TeaSerializer
    permission_classes = [permissions.IsAuthenticated]
    def get_queryset(self):
        _category = self.kwargs['pk']
        return Tea.objects.filter(category_id=_category)