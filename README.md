# docker-github-runner

Github Actions Runner with docker client in docker container

## Usage

### Register Runner

Get token from github repository settings tab:

1. Open `https://github.com/<username>/<repository>/settings/actions`
2. Click **Add runner**
3. Find this line `./config.sh --url <url> --token <token>`
4. Copy the actual url and token for later use

Pull this image and start a github runner container:

```bash
# replace <url> and <token> from previous step
docker run -d --name my-runner -e GITHUB_URL=<url> -e GITHUB_TOKEN=<token> seancheung/docker-github-runner
```

Wait until the runner successfully registered and running. You'll see the runner available in self-hosted runners list if everthing is done right.

### Environments

| Name         | required | default      | desc                    |
| ------------ | -------- | ------------ | ----------------------- |
| GITHUB_URL   | yes      |              | repo url                |
| GITHUB_TOKEN | yes      |              | runner token            |
| RUNNER_NAME  |          | container ID | name shown in list      |
| RUNNER_DIR   |          | `_work`      | relative work direcotry |

### Docker Intergration

This image ships only docker client(docker-cli). You should either mount the docker unix socket path from host to the container, or set it to work over TCP connections.

For docker engine on linux or docker desktop on MacOS/Linux:

```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock ... seancheung/docker-github-runner
```

For docker desktop on Windows:

```bash
docker run -e DOCKER_HOST="tcp://host.docker.internal:2375" ... seancheung/docker-github-runner
```

## Custom build Args

**CN_MIRROR**

> Use AliCloud registry mirror

Default: false

**RUNNER_URL**

> Github runner binary release archive url

Default: `https://github.com/actions/runner/releases/download/v2.165.2/actions-runner-linux-x64-2.165.2.tar.gz`

**DOCKER_URL**

> Docker binary release archive url

Default: `https://download.docker.com/linux/static/stable/x86_64/docker-18.06.3-ce.tgz`
