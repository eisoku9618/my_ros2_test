# my_ros2_test

## build

```
sudo docker build ./ -t my_awesome_ros2
```

## run

```
sudo docker run --rm  -it -e DISPLAY=$DISPLAY --privileged -v /tmp/.X11-unix:/tmp/.X11-unix my_awesome_ros2 /bin/bash
```
