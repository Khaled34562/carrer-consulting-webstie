# **How to start this project:**
For the development phase, Flutter files are located on the Front-End-Branch and the rest are on the Back-End-Branch

## If you want to demo the project, clone the main branch and skip to the the demo section


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

7. Make sure all pubspec.yaml files are using the same serverpod version (3 pubspec.yaml files)

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
