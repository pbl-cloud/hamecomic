module Hamecomic
  class ComicMaker
    include Hamecomic
    include OpenCV

    def initialize(image_info, options = {})
      @image = IplImage.load(File.join(DATA_PATH, image_info['filename']))
      mask_path = image_info['mask_name'] || get_mask_path(image_info['filename'])
      @mask  = IplImage.load(File.join(DATA_PATH, mask_path), CV_LOAD_IMAGE_GRAYSCALE)

      @face_size = CvSize.new(image_info['width'], image_info['height'])
      @face_rect = CvRect.new(image_info['left'], image_info['top'],
        image_info['width'], image_info['height'])
      @mask_rect = @mask.sub_rect(@face_rect)
    end

    def apply_transformation(image, options = {})
      image = IplImage.load(image) if image.is_a?(String)
      image = image.resize(@face_size)
      image = apply_manga_effect(image)

      new_image = @image.set_roi(@face_rect)
      new_image = image.copy(new_image, @mask_rect)

      new_image.reset_roi
      if options[:output]
        new_image.save(options[:output])
        Hamecomic.logger.debug { "Saving to #{options[:output]}" }
      end
      new_image
    end

    private
    def get_mask_path(filename)
      ext = File.extname(filename)
      File.basename(filename, ext) + "_mask" + ext
    end
  end
end
