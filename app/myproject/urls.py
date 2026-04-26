"""
URL configuration for the project.

For now the project contains a single app called `main` with one view.
"""
from django.contrib import admin
from django.urls import include, path


urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('main.urls')),
]