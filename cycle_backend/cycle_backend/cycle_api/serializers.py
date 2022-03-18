from cycle_backend.cycle_api.models import Place, User
from rest_framework import serializers

class PlaceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Place
        fields = ['id', 'name', 'lat', 'lon']

# User Serializer
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('email', 'first_name', 'last_name')

# Signup Serializer
class SignupSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('email', 'first_name', 'last_name', 'password')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = User.objects.create_user(validated_data['email'], validated_data['first_name'], validated_data['last_name'], validated_data['password'])
        return user