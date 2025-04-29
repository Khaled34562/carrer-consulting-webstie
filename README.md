# Career Consulting Platform

## Overview
The Career Consulting Platform is a web application designed to connect job seekers with career professionals. It offers personalized guidance, AI-powered tools, and expert resources to help users achieve their career goals. The platform facilitates direct communication with consultants and provides tools for CV building and review.

## Purpose
The platform aims to:
- Provide tailored interview preparation guidance from experts.
- Offer workplace insights to help users navigate diverse work environments.
- Deliver an AI-powered CV builder and enhancement tools.
- Enable direct consultations with career professionals through audio and video sessions.
- Share resources and best practices for career development.

## Basic Usage Guide

### Prerequisites
- A web browser.
- Access to the internet.
- User account (sign-up required).

### Steps
1. **Sign Up / Log In**:
   - Create an account or log in using your credentials.
2. **Browse Experts**:
   - Explore career consultants based on your needs.
3. **Book a Session**:
   - Schedule a video or audio session with an expert.
4. **Use AI CV Builder**:
   - Input your details to generate a professional CV.
5. **Access Resources**:
   - Browse articles and guides shared by specialists.


# How to start working on this project:
For the development phase, Flutter files are located on the Front-End-Branch and the rest are on the Back-End-Branch

If you want to demo the project, clone the main branch and skip to the the demo section

# Development

## Clone

1. In terminal:
```
git clone -b Back-End-Branch https://github.com/Khaled34562/carrer-consulting-webstie.git
```
2. Remove all contents of the directory (Except the .git directory) to a temporary file

3. Delete the now-empty carrer-consulting-website directory

4. In terminal
```
git clone -b Front-End-Branch https://github.com/Khaled34562/carrer-consulting-webstie.git
```
5. Return the carrerproj_server and the carrerproj_client directories to the root directory

6. Return the rest of the files to the new carrer-consulting-website directory

7. **Make sure all pubspec.yaml files are using the same serverpod version (3 pubspec.yaml files)**


# Demo
1. Open the Docker app and let it run in the background

2.a If you're using VS code, click the "run pub get" to resolve dependencies.

2.b If you're using an IDE that doesn't prompt you to run pub get, you need to resolve dependencies manually:

In a terminal:
```
cd root/carrerproj_client
dart pub get --no-example

cd ..
cd carrerproj_server
dart pub get --no-example

cd ..
cd carrerproj_flutter
flutter pub get --no-example
```
3. In a new terminal, navigate to the server directory of your project and start the Docker containers:
```
cd root/carrerproj_server 
docker compose up --build --detach
dart bin/main.dart --apply-migrations
```
4. In a new terminal, navigate to the Flutter app directory and run:
```
cd root/carrerproj_flutter  
flutter run
```
The project should start running after this step
