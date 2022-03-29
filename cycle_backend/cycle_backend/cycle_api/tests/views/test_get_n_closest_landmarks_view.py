from rest_framework.test import APITestCase
from django.urls import include, path, reverse
from cycle_backend.cycle_api.models import Place



class GetNClosestLandmarksViewTestCase(APITestCase):

    fixtures = [
        'cycle_backend/cycle_api/tests/fixtures/landmarks.json',
    ]

    def setUp(self):
        self.lat = 51.5972
        self.lon = 0.1767
        self.n = 5
        self.url = self.__get_url(self.lat, self.lon, self.n)


    """ Tests of the get_n_closest_landmarks view """

    def test_get_url(self):
        self.assertEqual(self.url, f'/closest/{self.n}/landmarks/from/{self.lat}/{self.lon}/')

    def test_can_retrieve_five_landmarks(self):
        response = self.client.get(self.url, format='json')
        self.assertTrue(len(response.data) == 5)

    def test_can_retrieve_one_landmark(self):
        response = self.client.get(self.__get_url(self.lat, self.lon, 1), format='json')
        self.assertTrue(len(response.data) == 1)

    def test_retrieves_only_as_many_as_it_can(self):
        response = self.client.get(self.__get_url(self.lat, self.lon, 6), format='json')
        self.assertTrue(len(response.data) == 5)

    def __get_url(self, lat, lon, n):
        return reverse('closest_landmarks', kwargs = {'lat': lat,
                                                       'lon': lon,
                                                       'n': n})
