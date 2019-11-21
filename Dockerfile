FROM ruby:2.6.5 AS build
WORKDIR /tmp
COPY Gemfile Gemfile.lock .
RUN bundle install --with=production

FROM ruby:2.6.5-slim
WORKDIR /root
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY . .

ENV LANG C.UTF-8
ENTRYPOINT ["bundle"]
CMD ["exec", "ruby", "web/iqdbs.rb"]
