from rest_framework.test import APITestCase
from django.urls import include, path, reverse
from cycle_backend.cycle_api.models import Place



class GetBikePointNumberOfEmptyDocksViewTestCase(APITestCase):

    def setUp(self):
        self.bikepoint_id = 'BikePoints_1'
        self.url = reverse('number_of_empty_docks', kwargs = {'bikepoint_id': self.bikepoint_id})
        self.response = self.client.get(self.url, format='json')

    """ Tests of the bikepoint_number_of_empty_docks view """

    def test_get_url(self):
        self.assertEqual(self.url, f'/bikepoints/{self.bikepoint_id}/number_of_empty_docks/')

    def test_response_length_is_one(self):
        self.assertTrue(len(self.response.data) == 1)

    def test_response_is_not_none(self):
        self.assertFalse(self.response.data['Number of empty docks'] == None)
