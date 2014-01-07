DEBUG = TEMPLATE_DEBUG = THUMBNAIL_DEBUG = True

COMPRESS_ENABLED = True
COMPRESS_OFFLINE = True

DATABASES = {
  'default': {
    'ENGINE': 'django.db.backends.sqlite3',
    'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
  }
}

SITE_URL = 'http://127.0.0.1:8000'

INSTALLED_APPS += ('devserver',)

FAVICON = '/static/failicon.png'
