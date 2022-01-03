docker build -t marlian/multi-client:latest -t marlian/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marlian/multi-server:latest -t marlian/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marlian/multi-worker:latest -t marlian/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marlian/multi-client:latest
docker push marlian/multi-server:latest
docker push marlian/milti-worker:latest

docker push marlian/multi-client:$SHA
docker push marlian/multi-server:$SHA
docker push marlian/milti-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=marlian/multi-server:$SHA
kubectl set image deployments/client-deployment client=marlian/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marlian/multi-worker:$SHA
