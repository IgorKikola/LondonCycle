from django.contrib.auth.hashers import check_password
from rest_framework.test import APITestCase
from cycle_backend.cycle_api.models import User
from rest_framework.authtoken.models import Token
from django.urls import reverse


class LoginViewTestCase(APITestCase):
    """ Tests of the login view """

    """ Set up """

    fixtures = [
        'cycle_backend/cycle_api/tests/fixtures/other_users.json'
    ]

    def setUp(self):
        self.request_body = {
            "username": "jimmypage@gmail.com",
            "password": "P@ssword123",
        }
        self.url = reverse('login')

    def test_login_url(self):
        self.assertEqual(self.url, '/login')

    """ Test that only POST method is valid """

    def test_login_with_get_method_is_not_allowed(self):
        response = self.client.get(self.url, format="json")
        expected_response_body_detail = "Method \"GET\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_login_with_put_method_is_not_allowed(self):
        response = self.client.put(self.url)
        expected_response_body_detail = "Method \"PUT\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_login_with_delete_method_is_not_allowed(self):
        response = self.client.delete(self.url)
        expected_response_body_detail = "Method \"DELETE\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_login_with_post_method_is_allowed(self):
        response = self.client.post(self.url)
        # Method not allowed
        self.assertNotEqual(response.status_code, 405)

    """ Test signup view with different/no input """

    def test_login_unsuccessful_if_no_user_request_body_is_not_provided(self):
        response = self.client.post(self.url)
        expected_response = "This field is required."
        self.assertEqual(response.data['username'][0], expected_response)
        self.assertEqual(response.data['password'][0], expected_response)

    def test_login_unsuccessful_if_no_user_exists_with_provided_details(self):
        response = self.client.post(self.url, self.request_body)
        expected_response = "Unable to log in with provided credentials."
        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.data['non_field_errors'][0], expected_response)

    def test_login_successful(self):
        User.objects.create_user(
            email="jimmypage@gmail.com",
            first_name="Jimmy",
            last_name="Page",
            password="P@ssword123"
        )
        # Try to log in to just created user
        response = self.client.post(self.url, self.request_body)
        self.assertEqual(response.status_code, 200)

        # Check if the returned token really belongs to that user
        user = User.objects.get(email=self.request_body['username'])
        # Check if the provided password is really the password of the user
        is_password_true = check_password(self.request_body['password'], user.password)
        self.assertTrue(is_password_true)

        token = Token.objects.get(user=user).key
        self.assertEqual(response.data['token'], token)
