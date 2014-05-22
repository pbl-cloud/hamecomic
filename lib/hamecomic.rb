require "opencv"
require "slop"
require "yaml"
require "logger"

require "hamecomic/common"
require "hamecomic/comic_maker"
require "hamecomic/cli"

module Hamecomic
  LIB_PATH  = File.expand_path(File.dirname(__FILE__))
  DATA_PATH = File.join(LIB_PATH, 'data')
  HAARCASCADE_CONFIG_FILENAME = 'haarcascade_frontalface_alt.xml'
  HAARCASCADE_CONFIG_PATH = File.join(DATA_PATH,
    "haarcascades", HAARCASCADE_CONFIG_FILENAME)

  IMAGE_INFO = ::YAML::load_file(File.join(DATA_PATH, 'image_info.yml'))

  IMAGES = IMAGE_INFO['images']

  @logger = Logger.new(STDOUT)
  @logger.level = Logger::WARN

  # Returns an array of IplImage with faces in comics.
  # Mode can be any image which has a key in 'image_info.yml'.
  # Current modes are 'mada', 'keikaku' and 'kansha'.
  # :output can be given in option to save images to a file.
  # If the output name contains '%d', it will be replaced by
  # the image number.
  def make_comic(image, mode, options = {})
    raise ArgumentError, 'invalid mode' unless IMAGES.has_key?(mode.to_s)
    image = OpenCV::IplImage.load(image) unless image.is_a?(OpenCV::IplImage)
    Hamecomic.logger.debug { "Starting faces detection." }
    faces = detect_faces(image)
    Hamecomic.logger.debug { "Detected #{faces.count} faces." }
    return [] if faces.empty?
    comic_maker = ComicMaker.new(IMAGES[mode.to_s], options)
    images = []
    faces.each_with_index.map do |face, i|
      output = options[:output] % i if options[:output]
      images << comic_maker.apply_transformation(face, options.merge(output: output))
    end
    images
  end

  def self.logger
    @logger
  end
end
