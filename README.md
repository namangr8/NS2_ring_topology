# NS2_ring_topology

Here we Simulated and analyzed the packet dropped in a congestion network for a ring topology with 2 TCP and 2 UDP connection and its effect on bandwidth and delay (using ns2 simulator).

![image](https://user-images.githubusercontent.com/76123992/118369743-2ab94580-b5c2-11eb-9db5-19d67de72e92.png)

- In this network of 8 nodes (node ‘0’ through ‘8’), two FTP applications are running over TCP at nodes n(0) & n(2).
- Another CBR application is running over UDP at node n(3) & node n(1).
- The destinations of node 0, 2, 3 and 1 are 5, 4, 6 and 7 respectively.
- All the nodes are arranged in a circle starting in clockwise direction from n(0) to n(7).
- All the links are full duplex and follow RED queuing mechanism. 

Schedule: All the TCP and UDP connections start at 0.2 second and stop at 10.5 second. Simulation time is from 0.2 sec to 11 sec.

