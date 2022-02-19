# frozen_string_literal: true

require 'httpx'
require 'json'
require 'logger'

module Pinata
  class Error < StandardError; end
  class NotFoundError < Error; end

  class Client
    attr_reader :api_endpoint, :gateway_endpoint

    def initialize(pinata_api_key, pinata_secret_api_key, api_endpoint, gateway_endpoint)
      @pinata_api_key = pinata_api_key
      @pinata_secret_api_key = pinata_secret_api_key
      @api_endpoint = api_endpoint
      @gateway_endpoint = gateway_endpoint
    end

    def add(path)
      res = HTTPX.plugin(:multipart).post(
        "#{@api_endpoint}/pinning/pinFileToIPFS",
        form: { file: File.new(path, 'rb') },
        headers: { 'pinata_api_key' => @pinata_api_key, 'pinata_secret_api_key' => @pinata_secret_api_key }
      )

      if res.status >= 200 && res.status < 300
        JSON.parse(res.body)
      else
        raise Error, res.body
      end
    end

    def cat(hash, offset, length)
      res = HTTPX.get("#{@api_endpoint}/api/v0/cat?arg#{hash}&offset=#{offset}&length=#{length}")
      res.body
    end

    def delete(hash)

    end

    def download(hash, &block)
      url = build_file_url(hash)
      res = HTTPX.get(url)

      if block_given?
        res.return!(&block)
      else
        res.return!
      end
    end

    def file_exists?(key)
      url = build_file_url(key)
      res = HTTPX.get "#{@gateway_endpoint}#{key}"
      res.code == 200
    end

    def build_file_url(hash)
      "#{@gateway_endpoint}/#{hash}"
    end
  end
end
