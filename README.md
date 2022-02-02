# Team Ram Major Group project

## Team members
The members of the team are:
- Mikolaj Gierak 
- Igor Jasutowicz 
- Nicolae-Marian Gartu
- Abbenayan Jeyakumar 
- Kavanan Karunakaran
- Govighan (Govi) Krishnakumar
- Flavio Melinte Citea 
- Vakaris Paulavicius 

## Project structure
The project is called `cycles`.
Admin login:  username = admin@admin.com  password = admin

## Deployed version of the application
The deployed version of the application can be found at ... 

## Installation instructions Backend
To install the software and use it in your local development environment, you must first set up and activate a local development environment.  From the root of the backend project:

```
$ virtualenv venv
$ source venv/bin/activate
```

Install all required packages:

```
$ pip3 install -r requirements.txt
```

Migrate the database:

```
$ python3 manage.py migrate
```

Seed the development database with:

```
$ python3 manage.py seed
```

Run all tests with:
```
$ python3 manage.py test
```
## Installation Instructions Frontend
To install the software and use it in your local development environment, you must first set up and activate a local development environment.  From the root of the frontend project:

Install all required packages:

```
$ flutter pub get
```

$ Analyse the project’s Dart source code:

```
$ flutter analyze
```

Run all tests with:
```
$ flutter test
```

## Sources
The packages used by this application are specified in `pubspec.yaml` and `requirements.txt`.
