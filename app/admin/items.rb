ActiveAdmin.register Item do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :price, :category_id, :picture

  form do |f|
    f.semantic_errors
    f.inputs

    f.inputs do
      f.input :picture, as:   :file,
                        hint: f.object.picture.present? ? image_tag(f.object.picture) : ""
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :price, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
