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
router.register(r'stops', views.StopViewSet, basename='stops')

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('closest/bikepoint/with/<int:min_empty_docks>/empty_docks/from/<str:lat>/<str:lon>/', views.get_closest_bikepoint_with_empty_docks, name = "closest_bikepoint_with_empty_docks"),
    path('closest/bikepoint/with/<int:min_bikes>/bikes/from/<str:lat>/<str:lon>/', views.get_closest_available_bikepoint, name = "closest_available_bikepoint"),
    path('closest/<int:n>/bikepoints/from/<str:lat>/<str:lon>/', views.get_n_closest_bikepoints, name = "closest_bikepoints"),
    path('closest/<int:n>/landmarks/from/<str:lat>/<str:lon>/', views.get_n_closest_landmarks, name = "closest_landmarks"),
    path('bikepoints/<str:bikepoint_id>/number_of_bikes', views.bikepoint_number_of_bikes, name = "number_of_bikes"),
    path('bikepoints/<str:bikepoint_id>/number_of_empty_docks', views.bikepoint_number_of_empty_docks, name = "number_of_empty_docks"),
    path('signup', views.signup_view, name = "signup"),
    path('login', obtain_auth_token, name = "login"),
    path('users/update', views.update_profile_view, name = "update_user"),
    path('users/get', views.get_user_details_view, name = "get_user_details"),
]
