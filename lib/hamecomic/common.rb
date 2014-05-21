module Hamecomic
  # Apply a manga effect on the input IPLImage
  def apply_manga_effect(image)
    gray = image.BGR2GRAY
    manga = gray.adaptive_threshold(255, block_size: 9)
    manga.GRAY2BGR
  end

  # Returns an array of IPLImage with the faces detected in the input
  def detect_faces(image)
    detector = OpenCV::CvHaarClassifierCascade::load(HAARCASCADE_CONFIG_PATH)
    detector.detect_objects(image).map { |rect| image.sub_rect(rect) }
  end
end
