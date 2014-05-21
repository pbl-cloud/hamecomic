require "opencv"
require "./hamecomic/common"
require "./hamecomic/comic_maker"

module Hamecomic
  LIB_PATH  = File.expand_path(File.dirname(__FILE__))
  DATA_PATH = File.join(LIB_PATH, 'data')
  HAARCASCADE_CONFIG_FILENAME = 'haarcascade_frontalface_alt.xml'
  HAARCASCADE_CONFIG_PATH = File.join(DATA_PATH,
    "haarcascades", HAARCASCADE_CONFIG_FILENAME)

  IMAGE_INFO = YAML::load_file(File.join(DATA_PATH, 'image_info.yml'))

  @@images = IMAGE_INFO['images']

  def make_comic(image, mode, options = {})
    raise ArgumentError, 'invalid mode' unless @@images.has_key?(mode.to_s)
    image = OpenCV::IplImage.load(image) unless image.is_a?(OpenCV::IplImage)
    faces = detect_faces(image)
    return [] if faces.empty?
    comic_maker = ComicMaker.new(@@images[mode.to_s], options)
    faces.map { |face| comic_maker.apply_transformation(face, options) }
  end
end
