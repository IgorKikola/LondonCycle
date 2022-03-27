from rest_framework.test import APITestCase
from django.urls import include, path, reverse
from cycle_backend.cycle_api.models import Place



class GetClosestBikePointWithAtLeastNEmptyDocksViewTestCase(APITestCase):

    fixtures = [
        'cycle_backend/cycle_api/tests/fixtures/bikepoints.json',
    ]

    def setUp(self):
        self.lat = 51.5972
        self.lon = 0.1767
        self.n = 0
        self.url = self.__get_url(self.lat, self.lon, self.n)
        self.response = self.client.get(self.url, format='json')


    """ Tests of the get_closest_bikepoint_with_at_least_n_empty_docks view """

    def test_get_url(self):
        self.assertEqual(self.url, f'/closest/bikepoint/with/{self.n}/empty_docks/from/{self.lat}/{self.lon}/')

    def test_status_code_is_200(self):
        self.assertEquals(self.response.status_code, 200)

    def test_bikepoint_exists(self):
        self.assertTrue(self.response.data['id'].startswith("BikePoints"))

    def __get_url(self, lat, lon, n):
        return reverse('get_closest_bikepoint_with_at_least_n_empty_docks',
                        kwargs = {'lat': lat,
                                  'lon': lon,
                                  'n': n})
