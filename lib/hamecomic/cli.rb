module Hamecomic
  class CLI
    extend Hamecomic

    @opts = Slop.new(help: true) do
      on 'i', 'image=', "Image to take faces from (required)", required: true
      on 'm', 'mode=', "Mode to create image {'keikaku' | 'mada' | 'kansha'} (required)", required: true
      on 'o', 'output=', "Output file. '%d' will be replaced by the image number.", default: 'comic-%d.png'
      on 'v', 'verbose', 'Enable verbose mode', default: false
    end

    def self.start
      @opts.parse rescue print_usage_and_exit(1)
      print_usage_and_exit(1) unless IMAGES.has_key?(@opts[:mode].to_s)
      make_comic(@opts[:image], @opts[:mode], @opts.to_h)
    end

    def self.print_usage_and_exit(exit_code)
      puts @opts.help
      exit exit_code
    end
  end
end
