from django.contrib.auth.base_user import BaseUserManager

""" User model manager """
class UserManager(BaseUserManager):

    def create_user(self, email, first_name, last_name, password=None):
        if not email:
            raise ValueError('Email must be provided')
        if not first_name:
            raise ValueError('User must have a first name')
        if not last_name:
            raise ValueError('User must have a last name')

        email = self.normalize_email(email)
        user = self.model(
            email=email, 
            first_name=first_name, 
            last_name=last_name
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, first_name, last_name, password):
        user = self.create_user(
            email, 
            first_name, 
            last_name, 
            password
        )
        user.is_staff = True
        user.is_superuser = True

        user.save(using=self._db)
        return user

