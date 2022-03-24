from django.test import TestCase
from cycle_backend.cycle_api.models import User
from django.core.exceptions import ValidationError


class UserModelTestCase(TestCase):
    """ Unit tests for User model """

    """ Set up """

    fixtures = [
        'cycle_backend/cycle_api/tests/fixtures/user.json',
        'cycle_backend/cycle_api/tests/fixtures/other_users.json'
    ]

    def setUp(self):
        self.user = User.objects.get(email='jimmypage@gmail.com')

    def test_valid_user(self):
        self._assert_user_is_valid()

    """ Email tests """

    def test_email_must_be_unique(self):
        second_user = User.objects.get(email='bobmarley@gmail.com')
        self.user.email = second_user.email
        self._assert_user_is_invalid()

    def test_email_must_have_text_before_the_at(self):
        self.user.email = '@gmail.com'
        self._assert_user_is_invalid()

    def test_email_must_have_at_most_one_at_symbol(self):
        self.user.email = 'example@@gmail.com'
        self._assert_user_is_invalid()

    def test_email_must_have_a_domain_name(self):
        self.user.email = 'example@.com'
        self._assert_user_is_invalid()

    def test_email_can_have_more_than_one_dot(self):
        self.user.email = 'example@gmail.co.uk'
        self._assert_user_is_valid()

    def test_email_must_have_at_least_one_dot(self):
        self.user.email = 'example@gmail'
        self._assert_user_is_invalid()

    def test_email_must_have_a_domain(self):
        self.user.email = 'example@gmail.'
        self._assert_user_is_invalid()

    """ First name tests """

    def test_first_name_must_start_with_a_capital_letter(self):
        self.user.first_name = 'jimmy'
        self._assert_user_is_invalid()

    def test_first_name_cannot_contain_capital_letters_in_the_middle(self):
        self.user.first_name = 'jiMmy'
        self._assert_user_is_invalid()

    def test_first_name_cannot_contain_capital_letter_at_the_end(self):
        self.user.first_name = 'jimmY'
        self._assert_user_is_invalid()

    def test_first_name_must_start_with_a_capital_and_be_followed_by_lowercase_letters(self):
        self.user.first_name = 'Jimmy'
        self._assert_user_is_valid()

    def test_first_name_cannot_contain_numbers(self):
        self.user.first_name = 'Jimmy3'
        self._assert_user_is_invalid()

    def test_first_name_cannot_contain_at_symbol(self):
        self.user.first_name = 'Jim@my'
        self._assert_user_is_invalid()

    def test_first_name_cannot_contain_hashtag_symbol(self):
        self.user.first_name = 'J#immy'
        self._assert_user_is_invalid()

    def test_first_name_cannot_contain_comma_symbol(self):
        self.user.first_name = 'Jimm,y'
        self._assert_user_is_invalid()

    def test_first_name_cannot_contain_asterix_symbol(self):
        self.user.first_name = 'Jimmy*'
        self._assert_user_is_invalid()

    def test_first_name_cannot_contain_dot_symbol(self):
        self.user.first_name = 'Jim.my'
        self._assert_user_is_invalid()

    def test_first_name_must_not_be_blank(self):
        self.user.first_name = ''
        self._assert_user_is_invalid()

    def test_first_name_may_not_be_unique(self):
        second_user = User.objects.get(email='bobmarley@gmail.com')
        self.user.first_name = second_user.first_name
        self._assert_user_is_valid()

    def test_first_name_length_must_not_exceed_50_characters(self):
        self.user.first_name = 'c' * 51
        self._assert_user_is_invalid()

    def test_first_name_length_can_be_exactly_50_characters(self):
        self.user.first_name = 'C' + ('c' * 49)
        self._assert_user_is_valid()

    """ Last name tests """

    def test_last_name_must_start_with_a_capital_letter(self):
        self.user.last_name = 'page'
        self._assert_user_is_invalid()

    def test_last_name_cannot_contain_capital_letters_in_the_middle(self):
        self.user.last_name = 'paGe'
        self._assert_user_is_invalid()

    def test_last_name_cannot_contain_capital_letter_at_the_end(self):
        self.user.last_name = 'pagE'
        self._assert_user_is_invalid()

    def test_last_name_must_start_with_a_capital_and_be_followed_by_lowercase_letters(self):
        self.user.last_name = 'Page'
        self._assert_user_is_valid()

    def test_last_name_cannot_contain_numbers(self):
        self.user.last_name = 'Page3'
        self._assert_user_is_invalid()

    def test_last_name_cannot_contain_at_symbol(self):
        self.user.last_name = 'P@ge'
        self._assert_user_is_invalid()

    def test_last_name_cannot_contain_hashtag_symbol(self):
        self.user.last_name = 'Pa#ge'
        self._assert_user_is_invalid()

    def test_last_name_cannot_contain_comma_symbol(self):
        self.user.last_name = 'Pa,ge'
        self._assert_user_is_invalid()

    def test_last_name_cannot_contain_asterix_symbol(self):
        self.user.last_name = 'Page*'
        self._assert_user_is_invalid()

    def test_last_name_cannot_contain_dot_symbol(self):
        self.user.last_name = 'Page.'
        self._assert_user_is_invalid()

    def test_last_name_must_not_be_blank(self):
        self.user.last_name = ''
        self._assert_user_is_invalid()

    def test_last_name_may_not_be_unique(self):
        second_user = User.objects.get(email='bobmarley@gmail.com')
        self.user.last_name = second_user.last_name
        self._assert_user_is_valid()

    def test_last_name_length_must_not_exceed_50_characters(self):
        self.user.last_name = 'c' * 51
        self._assert_user_is_invalid()

    def test_last_name_length_can_be_exactly_50_characters(self):
        self.user.last_name = 'C' + ('c' * 49)
        self._assert_user_is_valid()

    """ Extra functions for testing User model """

    def _assert_user_is_valid(self):
        try:
            self.user.full_clean()
        except ValidationError:
            self.fail('Test user should be valid')

    def _assert_user_is_invalid(self):
        with self.assertRaises(ValidationError):
            self.user.full_clean()
