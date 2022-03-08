from django.core.exceptions import ValidationError
from django.test import TestCase
from django.urls import reverse
from cycle_backend.cycle_api.models import Place

class BikepointLandmarkTestCase(TestCase):

    def test_some_passing_test(self):
        pass

#     def setUp(self):
#         self.BikeUrl = reverse('bikes')
#         self.LandmarkUrl = reverse('landmarks')
#         self.place = Place.objects.all()
#
#     """Tests of the bikepoint view."""
#
#     def test_get_bikepoint_url(self):
#         self.assertEqual(self.BikeUrl,'/bikes/')
#
#     def test_bike_id_must_not_be_blank(self):
#         self.place.id = ''
#         self.assertFalse(self.place)
#
#     def test_bike_name_must_not_be_blank(self):
#         self.place.name = ''
#         self.assertFalse(self.place)
#
#     def test_bike_lat_must_not_be_blank(self):
#         self.place.lat = ''
#         self.assertFalse(self.place)
#
#     def test_bike_lon_must_not_be_blank(self):
#         self.place.lon = ''
#         self.assertFalse(self.place)
#
#     def test_get_landmark_url(self):
#         self.assertEqual(self.LandmarkUrl,'/landmarks/')
#
#     def test_landmark_id_must_not_be_blank(self):
#         self.place.id = ''
#         self.assertFalse(self.place)
#
#     def test_landmark_name_must_not_be_blank(self):
#         self.place.name = ''
#         self.assertFalse(self.place)
#
#     def test_landmark_lat_must_not_be_blank(self):
#         self.place.lat = ''
#         self.assertFalse(self.place)
#
#     def test_landmark_lon_must_not_be_blank(self):
#         self.place.lon = ''
#         self.assertFalse(self.place)
