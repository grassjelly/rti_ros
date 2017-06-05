### Running the demo
1. Build the package
    ```sh
    $ cd catkin_ws
    $ catkin_make
    ```
2. Run the master.
    ```sh
    $ roscore
    ```
3. Run fake odometry data.
    ```sh
    $ rosrun rti_ros odomtest_pub
    ```
4. Run ROS-RTI node.
    ```sh
    $ rosrun rti_ros ros_to_dds 
    ```
5. Run ROS-RTI node.
    ```sh
    $ rosrun rti_ros dds_to_ros
    ```
6. Check if all the nodes worked.

    Check ROS-RTI.
    ```sh
    $ rtiddsspy
    ```
    Check RTI-ROS.
    ```sh
    $ rostopic echo odom2
    ```

### Developing your own RTI-ROS package using the code generator

1. Change the IDL file based on the message you want to pub-sub

2. Generate the codes.
    ```sh
    $ ./gencodes.sh
    ```
3. Build the package.
    ```sh
    $ cd catkin_ws
    $ catkin_make
    ```
4. Code!

### Reference

Credits to hengli for FindRTI.cmake file. https://github.com/hengli/vmav-ros-pkg/tree/master/middleware/dds_ros/cmake