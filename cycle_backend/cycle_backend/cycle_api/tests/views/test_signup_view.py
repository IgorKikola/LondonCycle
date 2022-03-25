from django.contrib.auth.hashers import check_password
from rest_framework.test import APITestCase
from cycle_backend.cycle_api.models import User
from rest_framework.authtoken.models import Token
from django.urls import reverse


class SignupViewTestCase(APITestCase):
    """ Tests of the signup view """

    """ Set up """

    fixtures = [
        'cycle_backend/cycle_api/tests/fixtures/other_users.json'
    ]

    def setUp(self):
        self.request_body = {
            "email": "jimmypage@gmail.com",
            "first_name": "Jimmy",
            "last_name": "Page",
            "password": "P@ssword123",
        }
        self.url = reverse('signup')

    def test_sign_up_url(self):
        self.assertEqual(self.url, '/signup/')

    """ Test that only POST method is valid """

    def test_signup_with_get_method_is_not_allowed(self):
        response = self.client.get(self.url)
        expected_response_body_detail = "Method \"GET\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_signup_with_put_method_is_not_allowed(self):
        response = self.client.put(self.url)
        expected_response_body_detail = "Method \"PUT\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_signup_with_delete_method_is_not_allowed(self):
        response = self.client.delete(self.url)
        expected_response_body_detail = "Method \"DELETE\" not allowed."
        # Method not allowed
        self.assertEqual(response.status_code, 405)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_signup_with_post_method_is_allowed(self):
        response = self.client.post(self.url)
        # Method not allowed
        self.assertNotEqual(response.status_code, 405)

    """ Test signup view with different/no input """

    def test_signup_with_no_data_in_the_request_body_gives_error_code_400(self):
        response = self.client.post(self.url)
        self.assertEqual(response.status_code, 400)

    def test_successful_signup(self):
        expected_response_message = "Signup was successful"
        before_count = User.objects.count()
        response = self.client.post(self.url, self.request_body)
        after_count = User.objects.count()
        # Successful signup
        self.assertEqual(before_count, after_count-1)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['email'], self.request_body['email'])
        self.assertEqual(response.data['first_name'], self.request_body['first_name'])
        self.assertEqual(response.data['last_name'], self.request_body['last_name'])
        self.assertEqual(response.data['response'], expected_response_message)

        # Check if the returned token really belongs to the new user
        user = User.objects.get(email=self.request_body['email'])
        token = Token.objects.get(user=user).key
        self.assertEqual(response.data['token'], token)

        # Check if the password was saved successfully
        is_password_true = check_password('P@ssword123', user.password)
        self.assertTrue(is_password_true)

    def test_signup_unsuccessful_with_email_of_a_wrong_format(self):
        expected_response_body_detail = "Enter a valid email address."
        before_count = User.objects.count()
        self.request_body['email'] = '@gmail.com'
        response = self.client.post(self.url, self.request_body)
        after_count = User.objects.count()
        self.assertEqual(before_count, after_count)
        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.data['detail'], expected_response_body_detail)

    def test_signup_unsuccessful_when_there_already_exists_a_user_with_the_same_email(self):
        expected_response_body_detail = "user with this email already exists."
        before_count = User.objects.count()
        # User with this email already exists (from fixtures)
        self.request_body['email'] = 'bobmarley@gmail.com'
        response = self.client.post(self.url, self.request_body)
        after_count = User.objects.count()
        self.assertEqual(before_count, after_count)
        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.data['detail'], expected_response_body_detail)
