from django.core.management.base import BaseCommand, CommandError
from cycle_backend.cycle_api.models import Place

class Command(BaseCommand):
    def handle(self, *args, **options):
        """
        Command to populate database with landmarks and bikepoints
        """
        print("Retreiving landmarks...")
        Place.get_all_landmarks()
        print("Retreiving bikepoints...")
        Place.get_all_bikepoints()
        print("Done.")
