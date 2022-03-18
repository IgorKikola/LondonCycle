from django.urls import include, path
from django.contrib import admin
from rest_framework import routers
from cycle_backend.cycle_api import views

appname='cycleapi'

router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet, basename='users')
router.register(r'places', views.PlaceViewSet, basename='places')
router.register(r'bikepoints', views.BikePointViewSet, basename='bikepoints')
router.register(r'landmarks', views.LandmarkViewSet, basename='landmarks')

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('closest/<int:n>/bikepoints/from/<str:lat>/<str:lon>/', views.get_n_closest_bikepoints),
    path('closest/<int:n>/landmarks/from/<str:lat>/<str:lon>/', views.get_n_closest_landmarks),
    path('bikepoints/<str:bikepoint_id>/number_of_bikes', views.bikepoint_number_of_bikes),
]
