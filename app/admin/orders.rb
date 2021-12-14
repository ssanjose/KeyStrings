ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :running, :created, :price, :user_id, :discount_id, :taxes

  form do |f|
    f.semantic_errors
    f.inputs

    f.inputs do
      f.has_many :order_histories, heading:       "Items Ordered",
                                   allow_destroy: true,
                                   new_record:    false do |a|
        a.input :title
      end
    end
    f.action
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:running, :created, :price, :user_id, :discount_id, :taxes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
