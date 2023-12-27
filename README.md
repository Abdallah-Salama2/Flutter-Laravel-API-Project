# Flutter-Laravel-API-Project
 Cross-platform Flutter app with Laravel backend. Beautiful UI, efficient RESTful API, secure authentication, and scalable database management.
 
## Getting Started

These instructions will guide you on how to set up and run both the Laravel backend and the Flutter frontend.

### Prerequisites

Make sure you have the following installed on your machine:

- [PHP](https://www.php.net/) (for Laravel)
- [Composer](https://getcomposer.org/) (for Laravel)
- [Node.js](https://nodejs.org/) (for Laravel Mix)
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (for Flutter)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/Abdallah-Salama2/Flutter-Laravel-API-Project
cd your-project
```
2.Run the localhost server

###Laravel Backend
1.Navigate to the Laravel backend directory:
```bash
cd flutter-api
```
2.Install Composer dependencies:
```bash
composer install
```
3.Copy the .env.example file to .env and configure your database settings:
```bash
cp .env.example .env
```
4.Generate an application key:
```bash
php artisan key:generate
```
5.Run migrations and seed the database:
```bash
php artisan migrate --seed
```
Start the Laravel development server:
```bash
php artisan serve
```
###Flutter Frontend
1.Navigate to the Flutter frontend directory:
```bash
cd frontend
```
2.Get Flutter dependencies:
```bash
flutter pub get
```
3.Run the Flutter app:
```bash
flutter run
```
