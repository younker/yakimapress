class Photo < ActiveRecord::Base
  belongs_to :product

  scope :photos, :conditions => "hidden != true"

  NO_IMAGE_PATH  = "/assets/not_available/medium/not_found.png"
  
  has_attached_file :photo,
                    :styles      => { :thumb => "95x95#", :large => "450x300" },
                    :default_url => "/assets/not_available/:style/not_found.png",
                    :url         => "/assets/photos/:id/:style/:basename.:extension",
                    :path        => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"

  validates_attachment_size :photo, :less_than => 1000.kilobytes

  validate :photo, :presence => true, :content_type => ['image/jpeg', 'image/jpg', 'image/gif', 'image/png']

  def alt
    self.photo_file_name.dasherize.titleize.gsub(/\.(jpeg|jpg|gif|png)$/i,'')
  end
end