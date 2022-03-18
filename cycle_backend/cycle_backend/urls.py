from django.urls import include, path
from django.contrib import admin
from rest_framework import routers
from rest_framework.authtoken.views import obtain_auth_token
from cycle_backend.cycle_api import views

appname='cycleapi'

router = routers.DefaultRouter()
router.register(r'places', views.PlaceViewSet, basename='places')
router.register(r'bikepoints', views.BikePointViewSet, basename='bikepoints')
router.register(r'landmarks', views.LandmarkViewSet, basename='landmarks')

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('signup', views.signup_view, name = "signup"),
    path('login', obtain_auth_token, name = "login"),
    path('users/update', views.update_profile_view, name = "update_user"),
    path('users/get', views.get_user_details_view, name = "get_user_details"),
]
