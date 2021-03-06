require 'faraday_middleware'

module OpenCalais
  module Connection

    ALLOWED_OPTIONS = [
      :headers,
      :url,
      :params,
      :request,
      :ssl
    ].freeze

    def add_default_options(opts={})
      headers = opts.delete(:headers) || {}
      options = {
        :headers => {
          # generic http headers
          'User-Agent'   => user_agent,
          'Accept'       => "#{OpenCalais::OUTPUT_FORMATS[:json]};charset=utf-8",

          # open calais default headers
          OpenCalais::HEADERS[:license_id]                    => api_key,
          OpenCalais::HEADERS[:content_type]                  => OpenCalais::CONTENT_TYPES[:raw],
          OpenCalais::HEADERS[:output_format]                 => OpenCalais::OUTPUT_FORMATS[:json],
          OpenCalais::HEADERS[:calculate_relevance_score]     => 'false',
          OpenCalais::HEADERS[:enable_metadata_type]          => 'SocialTags',
          OpenCalais::HEADERS[:doc_rdf_accessible]            => 'false',
          OpenCalais::HEADERS[:omit_outputting_original_text] => 'TRUE' # case matters here, actually
        },
        :ssl => {:verify => false},
        :url => endpoint
      }.merge(opts)
      options[:headers] = options[:headers].merge(headers)
      options
    end

    def connection(options={})
      opts = add_default_options(options)
      Faraday::Connection.new(opts) do |connection|
        connection.request :url_encoded
        connection.response :mashify
        connection.response :logger if ENV['DEBUG']

        if opts[:headers][OpenCalais::HEADERS[:output_format]] == OpenCalais::OUTPUT_FORMATS[:json]
          connection.response :json
        else
          connection.response :xml
        end

        connection.adapter(adapter)

      end

    end
  end
end
