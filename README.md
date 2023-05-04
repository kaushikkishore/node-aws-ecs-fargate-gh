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


