=================
baguette-gitolite
=================

Alpine Linux Docker running `gitolite <http://gitolite.com/gitolite/index.html>`_


Environment variables
======================

- ``SSH_PUB_KEY`` : The admin public key. Required at the first launch

Hooks
=====

| If you want to setup common hooks, put them to ``/tmp/hooks/``.
| At startup the docker will move them under ``/home/baguette/.gitolite/hooks/common/``
