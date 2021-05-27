FROM ruby:3.0.1 AS build
WORKDIR /tmp
COPY Gemfile Gemfile.lock ./
RUN bundle install

FROM ruby:3.0.1-slim
WORKDIR /root
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY . ./

EXPOSE 3000
CMD ["bin", "puma"]
