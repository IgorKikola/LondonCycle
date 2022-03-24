from django.contrib import admin
from django.contrib.auth.models import User
from cycle_backend.cycle_api.models import Place, Stop, User

admin.site.register(Place)
admin.site.register(User)
admin.site.register(Stop)

