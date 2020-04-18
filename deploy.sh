docker build -t lwlach/multi-client:latest -t lwlach/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lwlach/multi-server:latest -t lwlach/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lwlach/multi-worker:latest -t lwlach/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push lwlach/multi-client:latest
docker push lwlach/multi-server:latest
docker push lwlach/multi-worker:latest
docker push lwlach/multi-client:$SHA
docker push lwlach/multi-server:$SHA
docker push lwlach/multi-worker:$SHA

kubectl apply -f k8s
kuebctl set image deployments/client-deployment client=lwlach/multi-client:$SHA
kubectl set image deployments/server-deployment server=lwlach/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lwlach/multi-worker:$SHA