docker build -t goodfaith/multi-client:latest -t goodfaith/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t goodfaith/multi-server:latest -t goodfaith/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t goodfaith/multi-worker:latest -t goodfaith/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push goodfaith good faith/multi-client:latest
docker push goodfaith good faith/multi-server:latest
docker push goodfaith good faith/multi-worker:latest
docker push goodfaith good faith/multi-client:$SHA
docker push goodfaith good faith/multi-server:$SHA
docker push goodfaith good faith/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=goodfaith/multi-server:$SHA
kubectl set image deployments/client-deployment client=goodfaith/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=goodfaith/multi-worker:$SHA