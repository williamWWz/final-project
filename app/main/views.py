from django.http import HttpResponse


def index(request) -> HttpResponse:
    """Simple view that returns a greeting."""
    return HttpResponse("Hello, world! This is your Django app deployed on Azure.")