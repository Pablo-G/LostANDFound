class Reports < ActiveRecord::Migration
  def change
  	rename_column :reports, :type, :incidence_type
  end
end
