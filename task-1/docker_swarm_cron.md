# 🐳 Docker Swarm: Architecture & Scheduled Tasks

## What is Docker Swarm?

**Docker Swarm** is a native container orchestration tool that enables the management and deployment of containerized applications at scale. It allows users to create and manage a cluster of Docker hosts, known as a **Swarm**, and deploy applications across the cluster seamlessly, treating the entire collection of nodes as a single virtual resource.

### Core Architecture
A Swarm consists of two types of nodes:

- Managers: Handle cluster management tasks, maintaining the desired state of the swarm and scheduling services.

- Workers: Receive and execute tasks (containers) dispatched from the Manager nodes.

## The Challenge of Cronjobs in Swarm

Standard Linux `cron` is designed for single-node systems. In a Swarm, if you run a cron service with 3 replicas, the job will trigger 3 times. To prevent this, we use specific orchestration patterns.

### The "Service Restart" Pattern (Native)
This pattern uses Docker's internal `restart_policy` to simulate a schedule. It is **interval-based**, meaning it tracks time since the last exit, not the wall-clock.

 - Mechanism: The container runs a script, finishes its task, and exits. Swarm waits for a delay before starting it again.

 - The Drift Factor: If a job takes 5 minutes to run and has a 1-hour delay, it effectively runs every 65 minutes. Over time, the start time "drifts."

```yaml
services:
  test:
    image: busybox
    command: sh -c "echo 'Cleaning...' && sleep 10"
    deploy:
      restart_policy:
        condition: any
        delay: 30m
```

### Time-Based Scheduling (External Manager)
For strict wall-clock requirements, we use a sidecar like swarm-cronjob.

Logic: A manager container listens to the Docker socket. At the scheduled time, it scales a target service from replicas: 0 to replicas: 1.

```yaml
services:
  test:
    image: busybox
    command: date
    deploy:
      mode: replicated
      replicas: 0
      labels:
        - "swarm.cronjob.enable=true"
        - "swarm.cronjob.schedule=* * * * *"
        - "swarm.cronjob.skip-running=false"
      restart_policy:
        condition: none
```
