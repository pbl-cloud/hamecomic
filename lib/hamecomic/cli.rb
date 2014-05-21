class CLI
  def self.start
    opts = Slop.parse do
      on 'i', 'image=', "Image to take faces from"
      on 'm', 'mode=', "Mode to create image {'keikaku' | 'mada' | 'kansha'}"
      on 'v', 'verbose', 'Enable verbose mode'
    end
  end
end
