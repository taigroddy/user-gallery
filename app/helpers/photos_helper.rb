module PhotosHelper
  def url_submit(photo, gallery_id)
    if photo.new_record?
      gallery_photos_path(gallery_id: gallery_id)
    else
      gallery_photo_path(id: photo.id, gallery_id: gallery_id)
    end
  end
end
