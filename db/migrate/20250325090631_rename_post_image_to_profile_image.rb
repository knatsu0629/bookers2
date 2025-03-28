class RenamePostImageToProfileImage < ActiveRecord::Migration[6.1]
  def change
    ActiveStorage::Attachment.where(name: "post_image").update_all(name: "profile_image")
  end
end
