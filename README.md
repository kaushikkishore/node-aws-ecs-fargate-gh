# Node application - deployed on aws using fargate - Using github actions 

### Will update the documentation soon. 

01. Create a cluster 
02. Create a task definition (with the docker image) 
03. Create a load balancer 
04. Create a service 


while creating the service choose the alb 
if the alb is not accessible then go ahead and check the target group where the request is forwarded to 


To get the new deployment 
Go to cluster 
go to services -> update -> force new deployment

Other way is to change the task definition revision 
then update from the service that take new revision 

// Start from here 

01. Create a cluster + create a VPC also with the subnets 
02. Create a task definition Role - ecsTaskExecutionRole(this will be created initially when you will do the first wizard to get started)
    Either you can create a seprate task execution role or you can use the same execution role. 
03. Now create a service 
    Select the created VPC 
    While selecting or creating the security group Here you will specify custom tcp port of your application like 8000/3000
    from anywhere (later you can modify this when this will be behind loadbalancer)
    - leave autoscaling for now 
04. For new deployment, if there is no change in task definition then go ahead and select the service and then tell force new deployment 
If you want you can take it from task definition also you can modify the task definition and then you can update the service to take the new task definition. THis will remove existing container and will create a new one 

// If you want to add load balancer go ahead and delete the service 

01. Create a security group under the correct VPC which would have been created during the ecs steps 
02. For now allow all traffic from internet (inbound) 
03. For outboud do the same allow all traffic (outbound)
 
If you can go ahead with exiting task definitions then go ahead. Otherwise you want multi container depoyment then create a new task definitions. 

01. Create a mongo container 
02. Port mappings 
03. No care about healthcheck - Add this 
04. Add environment variables 

01. Add the application container 
02. port 8000
03. Add environment variables 
04. If you are configuring mongo ip then pass localhost
05. Add port for the mongo port 27017
06. You can specify here that mongo should start first 

Now define the volume 
01. Go little below post adding container 
02. Select add volume - Select the volume type as EFS - elastic file system 
03. While creating the EFS specify the name - select  correct vpc 
04. Type as standard
05. Select cutomise ->  Select Next -> check if the subnets are selected -> [You need a new sg for this here ]

    // Creating a new SG for the EFS 
    01. Select the same VPC 
    02. In inbound rule - Slect NFS - Custom -> choose ecs-security group which we created earlier - WHich means this NFS can take the traffic from only that ecs cluster no where else 
    03. For outbound allow all 

06. Refresh the security group and select the security group while defining the volume 
07. Now you can select the mount volume which you created 
08. Now go back to container - select the storage and logging center -> this step means we are mounting the volume to the container 
09. Select mount point mongo-db
10.  add path as /data/db (this you can find at mongo official image also)
11. 

Now you are going to create a service 
01. Select fargate type 
02. Select task definition 
03. Cluster would be automatically selected or select your cluster 
04. Give service name 
05. Give number of tasks - 2
06. Next -> Select the correct VPC and select the 2 Subnets 
07. Select the security group which was ecs-sg (allow all traffic to container)
08. Select application loadbalancer 
09. Go for load balancer creation 
10. Application load balancer -> internate facing -> ip v4 -> Select your VPC -> Select all subnets in the VPC 
    01. Creta e security group for the laod balancer 
    02. Inbound traffic will be http 80 or https 443 
    03. Create SG 
11. Select the created SG 
12. Now you need to create a target group 
    01. Go to create target group 
    02. Select Ip addresses for the fargate type 
    03. Name your target group 
    04. Check that correct VPC is selected  
    05. Add options to healthcheck 
    06. Advanced health check - Override the port and mention the port where the application is running 8000
    07. Make sure correct newtwork is sepcified 
    08. Create target group 
13. Now create the loadbalancer 
14. Go back to original ecs window and select the loadbalancer 
15. Now select which container to load balance, select the web application as the mongo is hidden behind
16. Select Add to loadbalancer 
17. Production listen port - 80 
18. Forwarded to select target group which we created 
19. You have option to specify autoscaling - Leave for now 
20. Now service will create task 

Security group change 
Go to ecs security group - 
01. Create new inbound rule - custom tcp - 3000 port - select the load balabcer security group 






