ActiveAdmin.register Movie do
  
  permit_params :title, :release_date, :director, :cast, :about, :category

  index do
    selectable_column
    id_column
    column :title
    column :release_date
    column :director
    column :category
    actions
  end

  filter :title
  filter :release_date
  filter :director
  filter :category

  form do |f|
    f.inputs do
      f.input :title
      f.input :release_date, as: :datepicker
      f.input :director
      f.input :cast
      f.input :about
      f.input :category
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :release_date
      row :director
      row :cast
      row :about
      row :category
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :release_date, :director, :cast, :about, :category
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :release_date, :director, :cast, :about, :category]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
