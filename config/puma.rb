workers ENV.fetch("PUMA_PROCESSES", Etc.nprocessors)
threads 0, ENV.fetch("PUMA_THREADS", 5)
worker_timeout ENV.fetch("PUMA_WORKER_TIMEOUT", 60)

backlog = ENV.fetch("PUMA_BACKLOG", 1024)
port = ENV.fetch("PUMA_PORT", 3000)
bind "tcp://0.0.0.0:#{port}?low_latency=true&backlog=#{backlog}"
#pidfile ENV.fetch("PUMA_PIDFILE", "tmp/pids/server.pid")
