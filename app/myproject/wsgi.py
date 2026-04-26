"""
WSGI config for myproject.

It exposes the WSGI callable as a module-level variable named ``application``.

This file was generated manually for the final project.
"""
import os

from django.core.wsgi import get_wsgi_application  # type: ignore


os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myproject.settings')

application = get_wsgi_application()