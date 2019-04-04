docker build \
    -t melvinkoopmans/multi-docker-client:latest \
    -t melvinkoopmans/multi-docker-client:$GIT_SHA \
    -f ./client/Dockerfile ./client

docker build \
    -t melvinkoopmans/multi-docker-server:latest \
    -t melvinkoopmans/multi-docker-server:$GIT_SHA \
    -f ./server/Dockerfile ./server

docker build \
    -t melvinkoopmans/multi-docker-worker:latest \
    -t melvinkoopmans/multi-docker-worker:$GIT_SHA \
    -f ./worker/Dockerfile ./worker

docker push melvinkoopmans/multi-docker-server:latest
docker push melvinkoopmans/multi-docker-client:latest
docker push melvinkoopmans/multi-docker-worker:latest

docker push melvinkoopmans/multi-docker-server:$GIT_SHA
docker push melvinkoopmans/multi-docker-client:$GIT_SHA
docker push melvinkoopmans/multi-docker-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=melvinkoopmans/multi-docker-server:$GIT_SHA
kubectl set image deployments/client-deployment server=melvinkoopmans/multi-docker-client:$GIT_SHA
kubectl set image deployments/worker-deployment server=melvinkoopmans/multi-docker-worker:$GIT_SHA