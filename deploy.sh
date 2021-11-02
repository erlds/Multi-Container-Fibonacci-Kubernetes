docker build -t erlds5518/multi-client:latest -t erlds5518/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t erlds5518/multi-server:latest -t erlds5518/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t erlds5518/multi-worker:latest -t erlds5518/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push erlds5518/multi-client:latest
docker push erlds5518/multi-server:latest
docker push erlds5518/multi-worker:latest

docker push erlds5518/multi-client:$SHA
docker push erlds5518/multi-server:$SHA
docker push erlds5518/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=erlds5518/multi-server:$SHA
kubectl set image deployments/client-deployment client=erlds5518/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=erlds5518/multi-worker:$SHA