from rest_framework.test import APITestCase
from django.urls import include, path, reverse



class GetRouteViewTestCase(APITestCase):

    def setUp(self):
        self.fromPlace = "51.4999851,-0.1291553"
        self.toPlace = "51.5039922,-0.1137916"
        self.url = self.__get_url(self.fromPlace, self.toPlace)
        self.response = self.client.get(self.url, format='json')

    """ Tests of the bikepoint_number_of_bikes view """

    def test_get_url(self):
        self.assertEqual(self.url, f'/get_route/from/{self.fromPlace}/to/{self.toPlace}/')

    def test_status_code_is_200(self):
        self.assertEquals(self.response.status_code, 200)

    def test_response_is_not_none(self):
        self.assertFalse(self.response.data == None)

    def __get_url(self, fromPlace, toPlace):
        return reverse('get_route', kwargs = {'fromPlace': fromPlace,
                                              'toPlace': toPlace})
