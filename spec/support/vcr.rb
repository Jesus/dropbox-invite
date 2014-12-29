VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  # your HTTP request service. You can also use fakeweb, webmock, and more
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.around(:each) do |example|
    if example.metadata[:cassette].nil?
      example.run
    else
      prefix = example.metadata[:described_class].to_s.downcase.gsub(/[^\w\/]+/, "_")
      name = example.metadata[:cassette]
      # options = example.metadata.
      #   slice(:record, :match_requests_on).
      #   except(:example_group)
      options = {}
      VCR.use_cassette(File.join(prefix, name), options) { example.run }
    end
  end
end
