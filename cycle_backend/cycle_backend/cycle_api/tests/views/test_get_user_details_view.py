from rest_framework.test import APIClient
from rest_framework.test import APITestCase
from cycle_backend.cycle_api.models import User
from rest_framework.authtoken.models import Token
from django.urls import reverse


class GetUserDetailsViewTestCase(APITestCase):
    """ Tests of the get user details view """

    fixtures = [
        'cycle_backend/cycle_api/tests/fixtures/user.json'
    ]

    def setUp(self):
        self.user = User.objects.get(email="jimmypage@gmail.com")
        self.token = Token.objects.get(user=self.user).key
        self.api_client = APIClient()
        self.url = reverse('get_user_details')

    def test_login_url(self):
        self.assertEqual(self.url, '/users/get/')

    """ Test that all methods without authorization token are not allowed """

    def test_unauthorized_get_user_details_with_post_method_is_not_allowed(self):
        response = self.client.post(self.url)
        expected_response_body_detail = "Authentication credentials were not provided."
        # Method not allowed, because authorization token is not provided
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_unauthorized_get_user_details_with_put_method_is_not_allowed(self):
        response = self.client.put(self.url)
        expected_response_body_detail = "Authentication credentials were not provided."
        # Method not allowed, because authorization token is not provided
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_unauthorized_get_user_details_with_delete_method_is_not_allowed(self):
        response = self.client.delete(self.url)
        expected_response_body_detail = "Authentication credentials were not provided."
        # Method not allowed, because authorization token is not provided
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_unauthorized_get_user_details_with_get_method_is_not_allowed(self):
        response = self.client.get(self.url)
        expected_response_body_detail = "Authentication credentials were not provided."
        # Method not allowed, because authorization token is not provided
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    """ Test that only GET method with authorization is allowed """

    def test_authorized_get_user_details_with_put_method_is_not_allowed(self):
        self.api_client.credentials(HTTP_AUTHORIZATION='Token ' + self.token)
        response = self.api_client.put(self.url)
        expected_response_body_detail = "Method \"PUT\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_authorized_get_user_details_with_delete_method_is_not_allowed(self):
        self.api_client.credentials(HTTP_AUTHORIZATION='Token ' + self.token)
        response = self.api_client.delete(self.url)
        expected_response_body_detail = "Method \"DELETE\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_authorized_get_user_details_with_post_method_is_not_allowed(self):
        self.api_client.credentials(HTTP_AUTHORIZATION='Token ' + self.token)
        response = self.api_client.post(self.url)
        expected_response_body_detail = "Method \"POST\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_authorized_get_user_details_is_successful_with_existing_authorization_token(self):
        self.api_client.credentials(HTTP_AUTHORIZATION='Token ' + self.token)
        response = self.api_client.get(self.url)
        # Method not allowed
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['email'], self.user.email)
        self.assertEqual(response.data['first_name'], self.user.first_name)
        self.assertEqual(response.data['last_name'], self.user.last_name)

    def test_authorized_get_user_details_is_unsuccessful_with_illegal_authorization_token(self):
        self.api_client.credentials(HTTP_AUTHORIZATION='Token illegalToken')
        response = self.api_client.get(self.url)
        # Method not allowed
        expected_response_body_detail = "Invalid token."
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data['detail'], expected_response_body_detail)
