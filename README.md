# Cosmocloud Deploy Helm Chart

This Helm chart deploys a three-tier application stack consisting of a Frontend, Backend, and Redis database. The chart is designed to be simple and easy to use, providing a basic setup for deploying these components in a Kubernetes cluster.

## Components

- **Frontend**: A sample frontend application served via a NodePort service.
- **Backend**: A sample backend application that connects to a Redis database.
- **Redis**: A Redis database used by the backend for data storage.

## Helm Chart Structure

cosmocloud-deploy/ -- This is your Helm chart
├── Chart.yaml -- Chart metadata
├── values.yaml -- Configuration values
├── README.md -- Documentation
└── templates/ -- Kubernetes manifests
├── deployment-backend.yaml
├── deployment-frontend.yaml
└── deployment-redis.yaml

## Pre-requisites
- minikube
- kubctl 
- helm

## Installation

To install the chart with the release name `testapp`:
helm install testapp ./cosmocloud-deploy --atomic --timeout 30s

This command will deploy the application stack in your Kubernetes cluster. The `--atomic` flag ensures that the installation process is rolled back if it fails, and the `--timeout` flag sets the maximum time for the installation process.

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter                   | Description                          | Default                      |
| --------------------------- | ------------------------------------ | ---------------------------- |
| `backend.image`             | Backend container image              | `shreybatra/sample-backend`  |
| `backend.env.REDIS_URI`     | Redis connection URI for the backend | `redis://redis-svc:6379`     |
| `frontend.image`            | Frontend container image             | `shreybatra/sample-frontend` |
| `frontend.env.BACKEND_URL`  | Backend URL for the frontend         | `http://backend-svc:8000`    |
| `redis.image`               | Redis container image                | `redis`                      |
| `service.frontend.type`     | Frontend service type                | `NodePort`                   |
| `service.frontend.port`     | Frontend service port                | `5175`                       |
| `service.frontend.nodePort` | Frontend NodePort                    | `31000`                      |
| `service.backend.type`      | Backend service type                 | `ClusterIP`                  |
| `service.backend.port`      | Backend service port                 | `8000`                       |
| `service.redis.type`        | Redis service type                   | `ClusterIP`                  |
| `service.redis.port`        | Redis service port                   | `6379`                       |

## Architecture

The application stack consists of three main components:

1. **Frontend**:

   - Deployed as a Kubernetes Deployment with a single replica.
   - Exposed via a NodePort service, allowing external access to the application.

2. **Backend**:

   - Deployed as a Kubernetes Deployment with a single replica.
   - Connects to the Redis database using the `REDIS_URI` environment variable.
   - Exposed via a ClusterIP service, accessible only within the cluster.

3. **Redis**:
   - Deployed as a Kubernetes Deployment with a single replica.
   - Exposed via a ClusterIP service, accessible only within the cluster.

## Testing

To test the deployment, you can use the following command:
helm test testapp

This will run a series of tests to ensure that all services are accessible and functioning correctly.

## Accessing the Application

Once the chart is deployed, you can access the frontend application using the following command:
minikube service frontend-svc

or
~ run minikube ip then access the application using http://<minikube-ip>:31000

## Uninstallation

To uninstall the `testapp` release:
helm uninstall testapp

This command will remove all the Kubernetes resources associated with the release.
