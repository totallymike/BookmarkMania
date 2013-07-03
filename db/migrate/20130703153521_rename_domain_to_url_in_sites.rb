class RenameDomainToUrlInSites < ActiveRecord::Migration
  def change
    rename_column :sites, :domain, :url
  end
end
