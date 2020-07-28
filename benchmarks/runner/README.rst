Setup environment variables
===========================

Before starting the runner, some variables need to be set up:

- Create a shared secret (``GITHUB_SECRET``)::

    openssl rand -hex 16

- Create a personal access token (Under *Settings → Developer settings →
  Personal access tokens*) for an account with write access to the
  probnum-benchmarks repository (``GITHUB_TOKEN``)

- Set the name of the runner using the variable ``RUNNER_NAME``

Put these variables in a file ``vars.env`` next to ``docker-compose.yml``
using the following format::

    GITHUB_SECRET=...
    GITHUB_TOKEN=...
    RUNNER_NAME=...


Setup webhook
=============

In the probnum repository, add a push webhook to ``http://<IP>:5678/push``
choosing ``application/json`` as content type, with the ``GITHUB_SECRET``
generated above.


Build and Run
=============

::

    docker-compose up --build
