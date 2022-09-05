1. what is entrypoint of mysql image   
```cat Dockerfile-mysql```
2. What is the CMD configured on the wordpress image?   
```cat Dockerfile-wordpress```
3. What is the final command run at startup when the wordpress image is run. Consider both ENTRYPOINT and CMD instructions   
```cat Dockerfile-wordpress```
4. What is the command run at startup when the ubuntu image is run?   
```cat Dockerfile-ubuntu```
5. Run an instance of the ubuntu image to run the sleep 1000 command at startup. Run it in detached mode.   
```docker run -d ubuntu sleep 1000```