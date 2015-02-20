Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'pages_admin_configurations_menu',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/pages_sidebar_menu'
)
