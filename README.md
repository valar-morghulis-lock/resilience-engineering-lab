🧪 Resilience Engineering Lab
This repository serves as a Resilience Sandbox. The goal is to move beyond "happy path" development by proactively injecting failures into a microservices environment to verify that our system's Stability Patterns (Circuit Breakers, Retries, Timeouts) behave as expected.

🏗️ Architecture
The lab uses a "Sword and Shield" approach:

The Sword (Chaos Mesh): A Kubernetes-native chaos engineering platform that orchestrates faults.

The Shield (Resilience4j): A lightweight fault-tolerance library used within the Target Services (SCM App).

Observability: Prometheus & Grafana to visualize the system "breaking" and "recovering."

🐒 The Chaos Experiments
1. The Latency Cascade (NetworkChaos)
Scenario: The Inventory Service experiences a 5-second network delay.

Hypothesis: The Order Service will exhaust its thread pool waiting for responses, causing a total system hang.

Mitigation: Implement a Circuit Breaker with a slidingWindowSize to fast-fail and return cached inventory data.

2. The Split-Brain (NetworkPartition)
Scenario: The Service-to-DB connection is severed, but the Service remains "Healthy."

Hypothesis: The Transaction Outbox pattern will capture events and retry once the connection is restored.

Verification: Check Kafka lag metrics and Outbox table state.

🛠️ Tech Stack
Runtime: Java 21 (Virtual Threads enabled)

Framework: Spring Boot 3.4

Resilience: Resilience4j

Infrastructure: Kubernetes (Kind/K3d), Helm

Chaos Engine: Chaos Mesh

Observability: Micrometer, Prometheus, Grafana

🚀 Getting Started
1. Prerequisites
Docker & Kubernetes (Kind recommended)

kubectl & Helm

2. Setup the Lab
Bash
# Create the local cluster
kind create cluster --name resilience-lab

# Install Chaos Mesh
curl -sSL https://mirrors.chaos-mesh.org/v2.6.2/install.sh | bash
3. Run an Experiment
Bash
# Apply the Latency Attack
kubectl apply -f ./chaos/network-delay.yaml

# Monitor the impact
kubectl port-forward svc/grafana 3000:3000
📊 Observability & Results
A successful experiment is defined by the Steady State. In this lab, we monitor:

Request Latency (p99): Should stay within bounds even during chaos.

Circuit Breaker State: Transitions from CLOSED -> OPEN -> HALF_OPEN.

Fallback Success Rate: How many users received "Estimated Data" vs. "Error Pages."


🚧 Roadmap
[x] Define Lab Architecture & Experiments

[ ] Setup K8s Infrastructure (Kind/Helm)

[ ] Implement Target SCM Microservices (Java 21)

[ ] Configure Chaos Mesh Scenarios

[ ] Build Observability Dashboards
