#build images
docker build -t kiry4/multi-client:latest -t kiry4/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kiry4/multi-server:latest -t kiry4/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kiry4/multi-worker:latest -t kiry4/multi-worker:$SHA -f ./worker/Dockerfile ./worker

#push images to dockerhub
docker push kiry4/multi-client:latest
docker push kiry4/multi-server:latest
docker push kiry4/multi-worker:latest
docker push kiry4/multi-client:$SHA
docker push kiry4/multi-server:$SHA
docker push kiry4/multi-worker:$SHA

#deploy to GKE
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=kiry4/multi-client:$SHA
kubectl set image deployments/server-deployment server=kiry4/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=kiry4/multi-worker:$SHA