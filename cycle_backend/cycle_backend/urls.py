from django.urls import include, path
from django.contrib import admin
from rest_framework import routers
from cycle_backend.cycle_api import views

router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'places', views.PlaceViewSet)
router.register(r'bikepoints', views.BikePointViewSet)
router.register(r'landmarks', views.LandmarkViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('route/<str:fromPlace>/to/<str:toPlace>', views.get_route),
]
