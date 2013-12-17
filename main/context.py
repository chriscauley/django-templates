from django.conf import settings

import os

def debug(request):
  return {'DEBUG': settings.DEBUG}

def nav(request):
  """
  nav should be a list of dictionaries like { 'name':str, 'url':str }
  "/" should be added after the for loop since s.startswith("/") is always true
  """
  nav = [
  ]
  for n in nav:
    if request.path.startswith(n['url']):
      n['current'] = True
  nav.insert(0,{'name': 'Home', 'url': '/', 'current': request.path == "/",})

  return {
    'nav': nav,
  }
