# gitlabrunner
Gitlab runner with added packages

---
This docker image is a normal [gitlab-runner](https://hub.docker.com/r/gitlab/gitlab-runner/) with a couple of packages included.

# Included:
1. python-pip
2. python3
3. sonar-scanner
4. awscli
5. cfn-nag

# Usage
1. Create an `/srv/gitlab-runner/general` directory
2. Create an `/srv/gitlab-runner/general/aws` directory
3. Create an `/srv/gitlab-runner/general/sonar` directory
4. Create an `/srv/gitlab-runner/general/sonar/conf` directory
5. add an aws credential file to the aws directory.
6. add a sonar-scanner.properties file to the sonar/conf directory

```bash
docker run --restart unless-stopped \
   -v /srv/gitlab-runner/config:/etc/gitlab-runner \
   -v /srv/gitlab-runner/general/aws:/home/gitlab-runner/.aws \
   -v /srv/gitlab-runner/general/sonar/conf:/opt/sonar-scanner/conf \
   -d --name runner superstienos/aws-gitlabrunner
```

Just like the base image, once the container is running start one specifically to register it:
```bash
docker run --rm -t -i -v /srv/gitlab-runner/config:/etc/gitlab-runner superstienos/aws-gitlabrunner register
```

# Multiple runners
I started using gitlab runners in docker so i'd be able to run multiple runners
more effectively. To this end you should start and register with different volumes.

An example run command would be:
```bash
docker run --restart unless-stopped \
   -v /srv/gitlab-runner/runner1:/etc/gitlab-runner \
   -v /srv/gitlab-runner/general/aws:/home/gitlab-runner/.aws \
   -v /srv/gitlab-runner/general/sonar/conf:/opt/sonar-scanner/conf \
   -d --name runner superstienos/aws-gitlabrunner
```
make note of the first `-v`. You could just increase the number. This way they will all use the same aws credentials and sonar configuration but they would be distinct runners.
