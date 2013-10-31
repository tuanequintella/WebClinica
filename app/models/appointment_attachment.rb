class AppointmentAttachment < ActiveRecord::Base
  attr_accessible :file, :notes

  has_attached_file :file, :styles => { :medium => "300x300>", :thumb => {geometry: "100x100#", format: "png"} }, :default_url => "/assets/images/attachment.png"

  validates_attachment :file, :size => { :in => 0..5.megabytes }

  before_post_process :resize_images

  # Helper method to determine whether or not an attachment is an image.
  def image?
    file_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pdf|pjpeg|png|x-png)$}
  end

  def image_url(size = :thumb)
    if image?
      file.url(size)
    else
      "file.png"
    end
  end

  private

  def resize_images
    return false unless image?
  end
end
