ActiveAdmin.register User do
  permit_params :email, :username, :password, :password_confirmation, :role

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :role
    actions
  end

  filter :email
  filter :username
  filter :role

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :password
      f.input :password_confirmation
      f.input :role
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :username
      row :role
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item :destroy, only: :show do
    link_to 'Delete User', admin_user_path(user), method: :delete, data: { confirm: 'Are you sure you want to delete this user?' } if authorized?(:destroy, user)
  end

  controller do
    def destroy
      user = User.find(params[:id])
      user.destroy
      redirect_to admin_users_path, notice: "User successfully deleted!"
    end
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :username, :password_digest, :role
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :username, :password_digest, :role]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
