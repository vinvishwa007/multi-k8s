docker build -t vinvishwa007/multi-server:latest -t vinvishwa007/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vinvishwa007/multi-client:latest -t vinvishwa007/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vinvishwa007/multi-worker:latest -t vinvishwa007/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vinvishwa007/multi-server:latest
docker push vinvishwa007/multi-client:latest
docker push vinvishwa007/multi-worker:latest

docker push vinvishwa007/multi-server:$SHA
docker push vinvishwa007/multi-client:$SHA
docker push vinvishwa007/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=vinvishwa007/multi-client:$SHA
kubectl set image deployments/server-deployment server=vinvishwa007/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=vinvishwa007/multi-worker:$SHA