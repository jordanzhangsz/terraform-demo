## Build with docker  
1. Build go application with below command  
   ```CGO_ENABLED=0 GOOS=linux go build```
2. Build image with docker file  
   ```docker build -t go-http:v1 .```
3. Run app with docker  
   ```docker run -it go-http:v1```

