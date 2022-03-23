from django.test import TestCase
from django.urls import include, path, reverse
from rest_framework.test import APIClient
from cycle_backend.cycle_api.models import User
from rest_framework.test import force_authenticate
from rest_framework.test import RequestsClient
from rest_framework.test import APITestCase
from rest_framework.test import APIRequestFactory


class GetNClosestBikepointsViewTestCase(APITestCase):
    """ Tests of the get_n_closest_bikepoints view """

    def setUp(self):
        self.lat = 51.5972
        self.lon = 0.1767
        self.n = 5
        self.url = reverse('closest_bikepoints', kwargs = {'lat': self.lat,
                                                           'lon': self.lon,
                                                           'n': self.n})
        # self.url = 'http://testserver' + self.url
        # self.client = RequestsClient()

    def test_get_url(self):
        self.assertEqual(self.url, f'/closest/{self.n}/bikepoints/from/{self.lat}/{self.lon}/')

    def test_can_retrieve_five_bikepoints(self):
        response = self.client.get('/closest/5/bikepoints/from/51.5972/0.1767/')
        print(response.data)
        self.assertTrue(len(response.data) == 0)
