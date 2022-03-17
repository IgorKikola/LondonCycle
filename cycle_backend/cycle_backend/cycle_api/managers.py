from django.contrib.auth.base_user import BaseUserManager

""" User model manager """
class UserManager(BaseUserManager):

    def create_user(self, email, first_name, last_name, password, **other_fields):

        if not email:
            raise ValueError('Email must be provided')

        email = self.normalize_email(email)
        user = self.model(email=email, first_name=first_name, last_name=last_name, **other_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, first_name, last_name, password, **other_fields):
        other_fields.setdefault('is_staff', True)
        other_fields.setdefault('is_superuser', True)

        if other_fields.get('is_staff') is not True:
            raise ValueError('Superuser must be a staff member.')

        if other_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must be a superuser.')


        user = self.create_user(email, first_name, last_name, password, **other_fields)
        user.save(using=self._db)

        return user

