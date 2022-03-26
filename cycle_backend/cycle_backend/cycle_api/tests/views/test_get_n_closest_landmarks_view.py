from rest_framework.test import APITestCase
from django.urls import include, path, reverse
from cycle_backend.cycle_api.models import Place



class GetNClosestLandmarksViewTestCase(APITestCase):

    def setUp(self):
        self.lat = 51.5972
        self.lon = 0.1767
        self.n = 5
        self.url = reverse('closest_landmarks', kwargs = {'lat': self.lat,
                                                           'lon': self.lon,
                                                           'n': self.n})
        Place.get_all_landmarks()


    """ Tests of the get_n_closest_landmarks view """

    def test_get_url(self):
        self.assertEqual(self.url, f'/closest/{self.n}/landmarks/from/{self.lat}/{self.lon}/')

    def test_can_retrieve_five_landmarks(self):
        response = self.client.get(self.url, format='json')
        self.assertTrue(len(response.data) == 5)
