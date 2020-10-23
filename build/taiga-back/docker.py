import os

def is_env_exists(environment_variable: str, default = ''):
    content = os.getenv(environment_variable)

    if content == '':
        return default
    else:
        return content

def is_env_bool_exists(environment_variable: str, default = False):
    content = os.getenv(environment_variable)

    if content == True:
        return True
    else:
        return False

MEDIA_URL = is_env_exists("MEDIA_URL")
STATIC_URL = is_env_exists("STATIC_URL")
SITES_FRONT_SCHEME = is_env_exists("SITES_FRONT_SCHEME")
SITES_FRONT_DOMAIN = is_env_exists("SITES_FRONT_DOMAIN")

SECRET_KEY = is_env_exists("SECRET_KEY")

DEBUG = is_env_exists("DEBUG")
PUBLIC_REGISTER_ENABLED = is_env_exists("PUBLIC_REGISTER_ENABLED")

DEFAULT_FROM_EMAIL = is_env_exists("DEFAULT_FROM_EMAIL")
SERVER_EMAIL = is_env_exists("SERVER_EMAIL")

CELERY_ENABLED = is_env_bool_exists("CELERY_ENABLED", True)

EVENTS_PUSH_BACKEND = is_env_exists("EVENTS_PUSH_BACKEND")
EVENTS_PUSH_BACKEND_OPTIONS = is_env_exists("EVENTS_PUSH_BACKEND_OPTIONS")
EVENTS_PUSH_BACKEND_OPTIONS = {"url": "amqp://taiga:taiga@rabbitmq:5672/taiga"}

# Uncomment and populate with proper connection parameters
# for enable email sending. EMAIL_HOST_USER should end by @domain.tld
EMAIL_BACKEND = is_env_exists("EMAIL_BACKEND", "django.core.mail.backends.smtp.EmailBackend")
EMAIL_USE_TLS = is_env_bool_exists("EMAIL_USE_TLS", False)
EMAIL_USE_SSL = is_env_bool_exists("EMAIL_USE_SSL", False)
EMAIL_HOST = is_env_exists("EMAIL_HOST", "localhost")
EMAIL_HOST_USER = is_env_exists("EMAIL_HOST_USER")
EMAIL_HOST_PASSWORD = is_env_exists("EMAIL_HOST_PASSWORD")
EMAIL_PORT = is_env_exists("EMAIL_PORT", 25)

# Uncomment and populate with proper connection parameters
# for enable github login/singin.
GITHUB_API_CLIENT_ID = is_env_exists("GITHUB_API_CLIENT_ID", "yourgithubclientid")
GITHUB_API_CLIENT_SECRET = is_env_exists("GITHUB_API_CLIENT_SECRET", "yourgithubclientsecret")

DATABASES = {
    "default": {
        "ENGINE": is_env_exists("DB_ENGINE"),
        "NAME": is_env_exists("DB_NAME"),
        "HOST": is_env_exists("DB_HOST"),
        "USER": is_env_exists("DB_USER"),
        "PASSWORD": is_env_exists("DB_PASSWORD")
    }
}
