from django.core.management.base import BaseCommand, CommandError
from cycle_backend.cycle_api.models import Place

class Command(BaseCommand):
    def handle(self, *args, **options):
        """
        Command to erase all Place instances from the database
        """
        print("Erasing all Place objects...")
        Place.objects.all().delete()
        print("Done.")
