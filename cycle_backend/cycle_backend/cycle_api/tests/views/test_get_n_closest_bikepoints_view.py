from rest_framework.test import APITestCase
from django.urls import include, path, reverse
from cycle_backend.cycle_api.models import Place



class GetNClosestBikepointsViewTestCase(APITestCase):

    def setUp(self):
        self.lat = 51.5972
        self.lon = 0.1767
        self.n = 5
        self.url = reverse('closest_bikepoints', kwargs = {'lat': self.lat,
                                                           'lon': self.lon,
                                                           'n': self.n})
        Place.get_all_bikepoints()


    """ Tests of the get_n_closest_bikepoints view """

    def test_get_url(self):
        self.assertEqual(self.url, f'/closest/{self.n}/bikepoints/from/{self.lat}/{self.lon}/')

    def test_can_retrieve_five_bikepoints(self):
        response = self.client.get(self.url, format='json')
        self.assertTrue(len(response.data) == 5)
