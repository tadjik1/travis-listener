web: bundle exec puma -t ${RUBY_MAX_THREADS:-16}:${RUBY_MAX_THREADS:-16} -p ${PORT:-3000} -e ${RACK_ENV:-development}
console: bundle exec irb -I lib -r travis/listener
