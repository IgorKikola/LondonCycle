from django.contrib.auth.hashers import check_password
from rest_framework.test import APIClient
from rest_framework.test import APITestCase
from cycle_backend.cycle_api.models import User
from rest_framework.authtoken.models import Token
from django.urls import reverse


class UpdateProfileViewTestCase(APITestCase):
    """ Tests of the update profile view """

    fixtures = [
        'cycle_backend/cycle_api/tests/fixtures/user.json',
        'cycle_backend/cycle_api/tests/fixtures/other_users.json'
    ]

    def setUp(self):
        self.user = User.objects.get(email="jimmypage@gmail.com")
        self.token = Token.objects.get(user=self.user).key

        self.request_body = {
            "email": "completelyNewEmail@gmail.com",
            "first_name": "Jimmy",
            "last_name": "Page",
            "password": "Led@Zeppelin428"
        }

        self.api_client = APIClient()
        self.url = reverse('update_user')

    def test_login_url(self):
        self.assertEqual(self.url, '/users/update')

    """ Test that all methods without authorization token are not allowed """

    def test_unauthorized_update_profile_with_post_method_is_not_allowed(self):
        response = self.client.post(self.url)
        expected_response_body_detail = "Authentication credentials were not provided."
        # Method not allowed, because authorization token is not provided
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_unauthorized_update_profile_with_put_method_is_not_allowed(self):
        response = self.client.put(self.url)
        expected_response_body_detail = "Authentication credentials were not provided."
        # Method not allowed, because authorization token is not provided
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_unauthorized_update_profile_with_delete_method_is_not_allowed(self):
        response = self.client.delete(self.url)
        expected_response_body_detail = "Authentication credentials were not provided."
        # Method not allowed, because authorization token is not provided
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_unauthorized_update_profile_with_get_method_is_not_allowed(self):
        response = self.client.get(self.url)
        expected_response_body_detail = "Authentication credentials were not provided."
        # Method not allowed, because authorization token is not provided
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    """ Test that only PUT method with authorization is allowed """

    def test_authorized_update_profile_with_delete_method_is_not_allowed(self):
        self.api_client.credentials(HTTP_AUTHORIZATION='Token ' + self.token)
        response = self.api_client.delete(self.url)
        expected_response_body_detail = "Method \"DELETE\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_authorized_update_profile_with_post_method_is_not_allowed(self):
        self.api_client.credentials(HTTP_AUTHORIZATION='Token ' + self.token)
        response = self.api_client.post(self.url)
        expected_response_body_detail = "Method \"POST\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_authorized_update_profile_with_get_method_is_not_allowed(self):
        self.api_client.credentials(HTTP_AUTHORIZATION='Token ' + self.token)
        response = self.api_client.get(self.url)
        expected_response_body_detail = "Method \"GET\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    """ Test update profile view with different/no input """

    def test_authorized_update_profile_is_successful_with_existing_authorization_token_and_valid_data(self):
        self.api_client.credentials(HTTP_AUTHORIZATION='Token ' + self.token)
        response = self.api_client.put(self.url, self.request_body)
        self.assertEqual(response.status_code, 200)
        expected_response_message = "Update was successful"
        self.assertEqual(response.data['response'], expected_response_message)
        # Check if user was updated successfully (get user with the new email and check if it's token is the same
        updated_user = User.objects.get(email=response.data['email'])
        expected_token = Token.objects.get(user=updated_user).key
        self.assertEqual(self.token, expected_token)
        # Check if the provided password is really the password of the user
        is_password_true = check_password(self.request_body['password'], updated_user.password)
        self.assertTrue(is_password_true)
        # Check if the request data is matching with updated user data and the response data
        self.assertEqual(response.data['email'], updated_user.email)
        self.assertEqual(response.data['email'], self.request_body['email'])
        self.assertEqual(response.data['first_name'], updated_user.first_name)
        self.assertEqual(response.data['first_name'], self.request_body['first_name'])
        self.assertEqual(response.data['last_name'], updated_user.last_name)
        self.assertEqual(response.data['last_name'], self.request_body['last_name'])

    def test_authorized_update_profile_is_unsuccessful_with_already_existing_email_that_belongs_to_other_user(self):
        self.api_client.credentials(HTTP_AUTHORIZATION='Token ' + self.token)
        self.request_body['email'] = "bobmarley@gmail.com"
        expected_response_detail = "user with this email already exists."
        response = self.api_client.put(self.url, self.request_body)
        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.data['detail']['email'][0], expected_response_detail)
